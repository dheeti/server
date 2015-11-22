import os, csv, itertools

from py2neo import Graph, Relationship


# host and port that neo4j instance is listening at
ENDPOINT = "localhost:7474"

# basic uri without authentication

# uri with user-password authentication
USER = "neo4j"
PASSWORD = "neo"

# link types
USER_ISSUE = "EVALUATES"
RANK = "RANKS"
MAP_VALUE = "MAP_VALUE"
MAP_OBJ = "MAP_OBJ"
MAP_POLICY = "MAP_POLICY"


def read_csv(csv_file):
    with open(csv_file) as f:
        return [row for row in csv.DictReader(f)]


def find_node(graph, label, node_id):
    args = dict(property_key="node_id", property_value=node_id)
    return graph.find_one(label, **args)


def match_link(graph, start_node, end_node, rel_type):
    args = dict(start_node=start_node, end_node=end_node, rel_type=rel_type)
    return graph.match_one(**args)


def get_node_type(node_id):
    prefix = node_id[0]
    if prefix == "v":
        return "Value"
    elif prefix == "o":
        return "Objective"
    elif prefix == "p":
        return "Policy"
    raise Exception


class Runner(object):

    def __init__(self, graph, **kwargs):
        self.graph = graph
        self.kwargs = kwargs
        self.runner()

    def runner():
        pass


class UserIssueRunner(Runner):

    def runner(self):
        users = self.kwargs["users"]
        issues = self.kwargs["issues"]
        # for each User and Issue pair make a link
        for user, issue in itertools.product(users, issues):
            self.create(user, issue)

    def create(self, user, issue):
        """
        Create link from Issue --> User
        """
        user_node = find_node(self.graph, "User", user["id"])
        issue_node = find_node(self.graph, "Issue", issue["id"])
        if not user_node or not issue_node:
            raise LookupError
        evaluates = Relationship(issue_node, USER_ISSUE, user_node)
        self.graph.create(evaluates)
        print issue_node, "-{0}->".format(USER_ISSUE), user_node


class UserRankRunner(Runner):

    def runner(self):
        for row in self.kwargs["ranks"]:
            self.create(row)

    def create(self, data):
        """
        Create a ranking from User --> (Value|Objective|Policy)
        """
        node_type = get_node_type(data["node_id"])
        user_node = find_node(self.graph, "User", data["user_id"])
        data_node = find_node(self.graph, node_type, data["node_id"])
        if not user_node or not data_node:
            print data
            raise LookupError
        if node_type == "Value":
            # direct MAP from User -> Value
            rank = int(data["rank"])
            map_link = Relationship(user_node, MAP_VALUE, data_node, Value=rank)
            self.graph.create(map_link)
        # RANK from User -> Node
        rank = Relationship(user_node, RANK, data_node, rank=int(data["rank"]))
        self.graph.create(rank)
        print user_node, "-{0}->".format(RANK), data_node


class UserMapRunner(Runner):

    def runner(self):
        for row in self.kwargs["maps"]:
            self.create(row)

    def create(self, data):
        """
        Create direct link between a pair of nodes.
        The pair of nodes come in two types:
           Type 1:
               start_node=Value
               end_node=Objective
           Type 2:
               start_node=Objective
               end_node=Policy

        When creating the link, lookup the individual User rankings
        for each of the nodes. Store this information in the link to
        speed up queries.
        """
        # discover node types (Value|Objective|Policy)
        start_node_type = get_node_type(data["start_id"])
        end_node_type = get_node_type(data["end_id"])
        # fetch user node and (Val/Obj or Obj/Pol) nodes
        user_node = find_node(self.graph, "User", data["user_id"])
        start_node = find_node(self.graph, start_node_type, data["start_id"])
        end_node = find_node(self.graph, end_node_type, data["end_id"])
        # raise error if nodes were not found
        # this is caused by errors in the csv of mapping nodes which
        # a user never ranked
        if not user_node or not start_node or not end_node:
            raise LookupError
        # fetch User rank for each node
        start_link = match_link(self.graph, user_node, start_node, RANK)
        end_link = match_link(self.graph, user_node, end_node, RANK)
        # raise error if links were not found
        # this should be a real error
        if not start_link or not end_link:
            raise LookupError
        # grab ranking and save it in link properties
        start_rank = start_link.properties["rank"]
        end_rank = end_link.properties["rank"]
        properties = {
            "user_id":data["user_id"],
            str(start_node_type).lower():start_rank,
            str(end_node_type).lower():end_rank
        }
        link_type = MAP_OBJ
        if end_node_type == "Policy":
            link_type = MAP_POLICY
        map_link = Relationship(start_node, link_type, end_node, **properties)
        self.graph.create(map_link)
        print start_node, "-{0}->".format(link_type), end_node


def runner(uri, data_directory):
    # create graph object for connecting to Neo instance
    graph = Graph(uri)
   
    # path to nodes and links
    nodes = os.path.join(data_directory, "nodes")
    links = os.path.join(data_directory, "links")

    # User --> Issue
    users = read_csv(os.path.join(nodes, "users.csv"))
    issues = read_csv(os.path.join(nodes, "issues.csv"))
    print "\nBuilding USER --> ISSUE links\n\n"
    UserIssueRunner(graph, users=users, issues=issues)
   
    # User --> Value
    # User --> Objective
    # User --> Policy
    user_ranks = read_csv(os.path.join(links, "user_ranks.csv"))
    print "\nBuilding USER --> (VALUE && OBJECTIVE && POLICY) links\n\n"
    UserRankRunner(graph, ranks=user_ranks)
   
    # User --> (Value --> Objective)
    # User --> (Objective --> Policy)
    user_maps = read_csv(os.path.join(links, "user_maps.csv"))
    print "\nMapping USER --> (VALUE --> OBJECTIVE) && (OBJECTIVE --> POLICY) links\n\n"
    UserMapRunner(graph, maps=user_maps)


if __name__ == "__main__":
    password = os.getenv("NEO4J_PASSWORD", PASSWORD)
    db_uri = "http://{0}:{1}@{2}/db/data".format(USER, password, ENDPOINT)
    neo4j_dir = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
    runner(db_uri, os.path.join(neo4j_dir, "data"))



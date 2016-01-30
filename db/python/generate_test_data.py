import sys
import os
import random
import csv


MAX_USERS = 50
DATA_DIR = "../data"
NODES = "nodes"
LINKS = "links"
CITIES = ["Portland", "Gresham", "Tigard", "Beaverton", "Milwaukie"]
RANKS = [-2, -1, 0, 1, 2]


# read in node ids from Values, Objectives and Policies files
def node_ids(filename):
    node_ids = []
    with open(filename, "rb") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            node_ids.append(row["id"])
    return node_ids


def write_ranks(links_dir, users, values=[], objectives=[], policies=[]):
    with open(os.path.join(links_dir, "user_ranks.csv"), "wb") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(["issue_id", "user_id", "node_id", "rank"])
        for user in users:
            for value in values:
                rank = random.randint(0, len(RANKS)-1) - 2
                writer.writerow(["i1", user, value, rank])
            for objective in objectives:
                rank = random.randint(0, len(RANKS)-1) - 2
                writer.writerow(["i1", user, objective, rank])
            for policy in policies:
                rank = random.randint(0, len(RANKS)-1) - 2
                writer.writerow(["i1", user, policy, rank])


def write_users(node_dir, users_count):
    users = []
    with open(os.path.join(node_dir, "users.csv"), "wb") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(["id", "name", "city"])
        for i in range(0, users_count):
            user_id = "u{0}".format(i)
            users.append(user_id)
            writer.writerow([user_id, i , CITIES[i % len(CITIES)]])
    return users


def getfile(node_dir, filename):
    nodefile = os.path.join(node_dir, filename)
    assert os.path.isfile(nodefile)
    return nodefile


def retrieve_files(node_dir):
    return dict(
        values_file=getfile(node_dir, "values.csv"),
        objectives_file=getfile(node_dir, "objectives.csv"),
        policies_file=getfile(node_dir, "policies.csv")
    )
    

def main():
    """
    Run: python generate_test_data.py [data directory] [number of users]
    """
    # get user parameters if specified, defaults otherwise
    users_count = MAX_USERS
    data_dir = DATA_DIR
    if len(sys.argv) >= 2:
        data_dir = sys.argv[1]
    if len(sys.argv) >= 3:
        users_count = int(sys.argv[2])
    
    
    nodes_dir = os.path.join(data_dir, NODES)
    links_dir = os.path.join(data_dir, LINKS)
    error = "Error: Directory < {0} > does not exist"
    assert os.path.isdir(nodes_dir), error.format(nodes_dir)
    assert os.path.isdir(links_dir), error.format(links_dir)

    # create a list of lots of users
    users = write_users(nodes_dir, users_count)
    files = retrieve_files(nodes_dir)
    nodes = dict(
        values=node_ids(files["values_file"]),
        objectives=node_ids(files["objectives_file"]),
        policies=node_ids(files["policies_file"])
    )
    write_ranks(links_dir, users, **nodes)


if __name__ == "__main__":
    main()

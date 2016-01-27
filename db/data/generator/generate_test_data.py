import random
import os, csv

MAX_USERS = 100
NODES = "../nodes"

OUTPUT = "output"

CITIES = ["Portland", "Gresham", "Tigard", "Beaverton", "Milwaukie"]
RANKS = [-2, -1, 0, 1, 2]

# read in Values, Objectives and Policies

def node_ids(filename):
    node_ids = []
    with open(filename, "rb") as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            node_ids.append(row["id"])
    return node_ids


def write_ranks(users, values, objectives, policies):
    with open(os.path.join(OUTPUT, "user_ranks.csv"), "wb") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(["issue_id", "user_id", "node_id", "rank"])
        for user in users:
            for value in values:
                rank = random.randint(0, 4) - 2
                writer.writerow(["i1", user, value, rank])

            for objective in objectives:
                rank = random.randint(0, 4) - 2
                writer.writerow(["i1", user, objective, rank])

            for policy in policies:
                rank = random.randint(0, 4) - 2
                writer.writerow(["i1", user, policy, rank])


def write_users():
    users = []
    with open(os.path.join(OUTPUT, "users.csv"), "wb") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(["id", "name", "city"])
        
        for i in range(0, MAX_USERS):
            user_id = "u{0}".format(i)
            users.append(user_id)
            writer.writerow([user_id, i , CITIES[i % 5]])
    return users


def main():
    # create a list of lots of users
    users = write_users()
    
    # read in possible Value, Objective and Policy node id's
    values = node_ids(os.path.join(NODES, "values.csv"))
    objectives = node_ids(os.path.join(NODES, "objectives.csv"))
    policies = node_ids(os.path.join(NODES, "policies.csv"))

    write_ranks(users, values, objectives, policies)


if __name__ == "__main__":
    main()


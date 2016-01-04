// delete all nodes and their relationships
BEGIN
MATCH (node:Issue) DETACH DELETE node;
MATCH (node:User) DETACH DELETE node;
MATCH (node:Value) DETACH DELETE node;
MATCH (node:Objective) DETACH DELETE node;
MATCH (node:Policy) DETACH DELETE node;
MATCH (node:Map) DETACH DELETE node;
COMMIT

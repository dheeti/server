// create test User nodes and define some relationships using csv files
// User -[SUPPORTS]-> Policy
// User -[SUPPORTS]-> Value
// User -[SUPPORTS]-> Objective


// load test users

BEGIN
LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/testdata/users.csv' AS line
CREATE
    (user:User { id: line.id, name: line.name, city: line.city});
COMMIT


// unique constraint on id builds an index for querying

BEGIN
CREATE CONSTRAINT ON (user:User) ASSERT user.id IS UNIQUE;
COMMIT


// load users -> values relationships

BEGIN
LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/testdata/user_value.csv' AS line
MATCH
    (user:User { id: line.userID}),
    (value:Value { id: line.valueID})
CREATE
    (user)-[:SUPPORTS { value: toInt(line.rank) }]->(value);
COMMIT


// load users -> objectives relationships

BEGIN
LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/testdata/user_objective.csv' AS line
MATCH
    (user:User { id: line.userID}),
    (objective:Objective { id: line.objectiveID})
CREATE
    (user)-[:SUPPORTS { value: toInt(line.rank) }]->(objective);
COMMIT


// load users -> policies relationships

BEGIN
LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/testdata/user_policy.csv' AS line
MATCH
    (user:User { id: line.userID}),
    (policy:Policy { id: line.policyID})
CREATE
    (user)-[:SUPPORTS { value: toInt(line.rank) }]->(policy);
COMMIT



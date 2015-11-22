BEGIN

LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/data/nodes/issues.csv' AS line
CREATE (:Issue { node_id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/data/nodes/users.csv' AS line
CREATE (:User { node_id: line.id, name: line.name, city: line.city});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/data/nodes/values.csv' AS line
CREATE (:Value { node_id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/data/nodes/objectives.csv' AS line
CREATE (:Objective { node_id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/data/nodes/policies.csv' AS line
CREATE (:Policy { node_id: line.id, name: line.name});

COMMIT

BEGIN

CREATE CONSTRAINT ON (node:Issue) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:User) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Value) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Objective) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Policy) ASSERT node.node_id IS UNIQUE;

COMMIT


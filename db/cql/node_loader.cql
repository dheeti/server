BEGIN

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/users.csv' AS line
CREATE (:User { node_id: line.id, name: line.name, city: line.city});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/communities.csv' AS line
CREATE (:Community { node_id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/issues.csv' AS line
CREATE (:Issue { node_id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/values.csv' AS line
CREATE (:Value { node_id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/objectives.csv' AS line
CREATE (:Objective { node_id: line.id, issue_id: line.issue_id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/policies.csv' AS line
CREATE (:Policy { node_id: line.id, issue_id: line.issue_id, name: line.name});

COMMIT


BEGIN

CREATE CONSTRAINT ON (node:User) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Community) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Issue) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Value) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Objective) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Policy) ASSERT node.node_id IS UNIQUE;

CREATE INDEX ON :Objective(issue_id);
CREATE INDEX ON :Policy(issue_id);

COMMIT


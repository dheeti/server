BEGIN

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/issues.csv' AS line
CREATE (:Issue { node_id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/users.csv' AS line
CREATE (:User { node_id: line.id, name: line.name, city: line.city});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/values.csv' AS line
CREATE (:Value { node_id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/objectives.csv' AS line
CREATE (:Objective { node_id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/nodes/policies.csv' AS line
CREATE (:Policy { node_id: line.id, name: line.name});

COMMIT

BEGIN

CREATE CONSTRAINT ON (node:Issue) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:User) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Value) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Objective) ASSERT node.node_id IS UNIQUE;
CREATE CONSTRAINT ON (node:Policy) ASSERT node.node_id IS UNIQUE;

COMMIT

BEGIN

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/links/issue_values.csv' AS line
MATCH (i:Issue), (v:Value)
WHERE i.node_id = line.issue_id AND v.node_id = line.value_id
CREATE (i)-[:HAS]->(v);

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/links/issue_objectives.csv' AS line
MATCH (i:Issue), (o:Objective)
WHERE i.node_id = line.issue_id AND o.node_id = line.objective_id
CREATE (i)-[:HAS]->(o);

LOAD CSV WITH HEADERS FROM 'file:///vagrant/data/links/issue_policies.csv' AS line
MATCH (i:Issue), (p:Policy)
WHERE i.node_id = line.issue_id AND p.node_id = line.policy_id
CREATE (i)-[:HAS]->(p);

COMMIT

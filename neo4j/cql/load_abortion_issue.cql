// create Value, Policy and Objective nodes out of abortion issue csv files

BEGIN

LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/abortion/values.csv' AS line
CREATE (value:Value { id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/abortion/policies.csv' AS line
CREATE (policy:Policy { id: line.id, name: line.name});

LOAD CSV WITH HEADERS FROM 'file:///vagrant/neo4j/abortion/objectives.csv' AS line
CREATE (objective:Objective { id: line.id, name: line.name});

COMMIT


// unique constraint on id builds an index for defining relationships
// and querying nodes

BEGIN

CREATE CONSTRAINT ON (value:Value) ASSERT value.id IS UNIQUE;
CREATE CONSTRAINT ON (policy:Policy) ASSERT policy.id IS UNIQUE;
CREATE CONSTRAINT ON (objective:Objective) ASSERT objective.id IS UNIQUE;

COMMIT

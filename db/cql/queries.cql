// This file contains some example queries using Neo4j's Cypher Language.
// The intent is to show how different queries might work when designing
// the actual data model


// Example 0:
// Return the entire graph

MATCH (node) RETURN node;



// Example 1:
// Return name and city property for each User node

MATCH (x:User) RETURN x.name, x.city;



// Example 2:
// Return id and description for each Value node

MATCH (x:Value) RETURN x.node_id, x.name;



// Example 3:
// Return Users who have Ranked different Values

MATCH
    (user:User),
    (value:Value)
MATCH
    (user)-[rel:RANKS]->(value)
RETURN user, rel, value;



// Example 4:
// Return average RANK assigned to each Value over all Users

MATCH
    (user:User),                    
    (value:Value)                   
MATCH
    (user)-[rel:RANKS]->(value)
RETURN value.name, avg(rel.rank), count(*);



// Example 5:
// Find all values that were mapped to objectives and return number
// of mappings and average rank for both value of objective 

MATCH
    (val:Value)--(map:Map)--(obj:Objective),
    (user:User)--(map:Map),
    (user:User)-[vRank:RANKS]-(val:Value),
    (user:User)-[oRank:RANKS]-(obj:Objective)
RETURN val.name, obj.name, avg(vRank.rank), avg(oRank.rank), count(user.node_id);


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

MATCH (x:Value) RETURN x.id, x.name;



// Example 3:
// Return Users who have Ranked different Values

MATCH
    (user:User),
    (value:Value)
MATCH
    (user)-[rel:SUPPORTS]->(value)
RETURN user, rel, value;



// Example 4:
// Return average SUPPORT rank assigned to each Value over all Users

MATCH
    (user:User),                    
    (value:Value)                   
MATCH
    (user)-[rel:SUPPORTS]->(value)
RETURN value.name, avg(rel.value), count(*);



// Example 5:
// For policy 'p4' (Invest in birth control education programs) and
// all Users who ranked it, is there a trend in how they also ranked Values?

MATCH
    (user:User),
    (value:Value),
    (policy:Policy)
MATCH
    (user)-[vrel:SUPPORTS]->(value),
    (user)-[prel:SUPPORTS]->(policy)
WHERE
    policy.id = 'p4'
RETURN
    count(user.id) AS connections,
    value.id, value.name, avg(vrel.value) AS avg_value_rank,
    policy.id, policy.name, avg(prel.value) AS avg_policy_rank 
ORDER BY count(user.id) DESC, value.id, policy.id;



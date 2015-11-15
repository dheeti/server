BEGIN
MATCH (user:User) DETACH DELETE user;
MATCH (value:Value) DETACH DELETE value;
MATCH (objective:Objective) DETACH DELETE objective;
MATCH (policy:Policy) DETACH DELETE policy;
COMMIT

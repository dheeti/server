#!/bin/bash

# add neo4j executables to our PATH
export PATH=$PATH:/opt/neo4j/neo4j-community-2.3.1/bin

# clear database
neo4j-shell -c < /vagrant/neo4j/cql/clear_db.cql
# load abortion issue nodes
neo4j-shell -c < /vagrant/neo4j/cql/load_abortion_issue.cql
# load test users and rankings
neo4j-shell -c < /vagrant/neo4j/cql/load_abortion_testdata.cql


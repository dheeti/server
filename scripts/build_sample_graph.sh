#!/bin/bash

# add neo4j executables to our PATH
export PATH=$PATH:/opt/neo4j/neo4j-community-2.3.1/bin

# clear database
neo4j-shell -c < /vagrant/neo4j/cql/clear_db.cql
neo4j-shell -c < /vagrant/neo4j/cql/node_loader.cql
python /vagrant/neo4j/python/relationship_builder.py

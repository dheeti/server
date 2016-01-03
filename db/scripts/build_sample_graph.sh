#!/bin/bash

# add neo4j executables to our PATH
export PATH=$PATH:/opt/neo4j/neo4j-community-2.3.1/bin

# clear database
neo4j-shell -c < /vagrant/cql/clear_db.cql
neo4j-shell -c < /vagrant/cql/node_loader.cql
python /vagrant/python/relationship_builder.py

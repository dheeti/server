#!/bin/bash

# add neo4j executables to our PATH
export PATH=$PATH:/opt/neo4j/neo4j-community-2.3.1/bin

# python .../build_sample_data.py [data directory] [number of test users]
python /vagrant/python/generate_test_data.py /vagrant/data 30

# clear database
neo4j-shell -c < /vagrant/cql/clear_db.cql
neo4j-shell -c < /vagrant/cql/node_loader.cql
python /vagrant/python/relationship_builder.py

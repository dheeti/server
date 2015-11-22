#!/bin/bash

puppet_neo4j=https://github.com/meyersj/puppet-neo4j.git
export NEO4J_PASSWORD=neo

# install puppet
apt-get update
apt-get install -y git puppet

# install required puppet modules
puppet module install puppetlabs-java
puppet module install puppetlabs-vcsrepo
puppet module install puppetlabs-concat
git clone -b develop $puppet_neo4j /etc/puppet/modules/neo4j

# copy local modules into puppet modules
cp -r /vagrant/puppet/modules/* /etc/puppet/modules

# create admin user and add everyones public keys
# to its ssh authorized_keys file
puppet apply /vagrant/puppet/users.pp
adduser admin sudo

# apply puppet configuration locally
puppet apply /vagrant/puppet/setup.pp

# prevent admin user from needing a password for sudo commands
echo "admin  ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# disable password logins
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
echo "export EDITOR=/usr/bin/vim" >> /etc/environment

# ubuntu node uses `nodejs` executable while churchill build uses `node` executable
ln -s `which nodejs` /usr/bin/node

# set default password for neo4j user and build sample graph using abortion issue
neoauth neo4j neo4j $NEO4J_PASSWORD
service neo4j restart
/vagrant/scripts/build_sample_graph.sh

service ssh restart
service churchill-node start

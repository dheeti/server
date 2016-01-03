#!/bin/bash

repo=https://github.com/psu-capstone/neo4j.git
puppet_neo4j=https://github.com/meyersj/puppet-neo4j.git
export DLAB_NEO4J_PASSWORD=neo

# install puppet
apt-get update
apt-get install -y git puppet

# install required puppet modules
puppet module install puppetlabs-java
puppet module install puppetlabs-concat
git clone $puppet_neo4j /etc/puppet/modules/neo4j

# make local modules available to system
cp -r /vagrant/puppet/modules/* /etc/puppet/modules

# apply puppet configuration
puppet apply /vagrant/puppet/setup.pp

# prevent admin user from needing a password for sudo commands
echo "admin  ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# disable password logins
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
echo "export EDITOR=/usr/bin/vim" >> /etc/environment

# set default password for neo4j user and build sample graph using abortion issue
neoauth neo4j neo4j $DLAB_NEO4J_PASSWORD
service neo4j restart
/vagrant/scripts/build_sample_graph.sh

# add rc.local script that redirects port 80 to neo port 7474
cp /vagrant/scripts/rc.local /etc/rc.local

# set default git config and make sure remote is https instead of ssh
#git config --global user.email "admin@dlab.com"
#git config --global user.name "Admin"
#git --git-dir=/vagrant/.git --work-tree=/vagrant remote set-url origin $repo

reboot

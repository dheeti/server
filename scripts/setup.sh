#!/bin/bash

# install puppet
apt-get update
apt-get install -y puppet

# install required puppet modules
puppet module install puppetlabs-java
puppet module install amosjwood-neo4j
puppet module install puppetlabs-vcsrepo

# copy local modules into puppet modules
cp -r /vagrant/puppet/modules/* /etc/puppet/modules

# apply puppet configuration locally
puppet apply /vagrant/puppet/setup.pp

# create admin user and apply add everyones public keys
# to its ssh authorized_keys file
puppet apply /vagrant/puppet/users.pp
adduser admin sudo

# disable password logins
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
echo "export EDITOR=/usr/bin/vim" >> /etc/environment

# ubuntu node uses `nodejs` executable while churchill build uses `node` executable
ln -s `which nodejs` /usr/bin/node

# TODO add admin user to sudoers either with pupper or shell command

service ssh restart
service churchill-node start

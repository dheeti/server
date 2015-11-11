#!/bin/bash

# install puppet
apt-get update
apt-get install -y puppet

# install required puppet modules
puppet module install puppetlabs-java
puppet module install amosjwood-neo4j

# copy local modules into puppet modules
cp -r /vagrant/puppet/modules/* /etc/puppet/modules

# apply puppet configuration locally
puppet apply /vagrant/puppet/setup.pp

# disable password logins
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
echo "export EDITOR=/usr/bin/vim" >> /etc/environment

service ssh restart


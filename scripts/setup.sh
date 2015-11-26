#!/bin/bash

# install puppet
apt-get update
apt-get install -y git puppet

# install required puppet modules
puppet module install puppetlabs-vcsrepo

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

# add rc.local script that redirects port 80 to nodejs port 3000
mv /vagrant/scripts/rc.local /etc/rc.local

reboot

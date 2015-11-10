#!/bin/bash

user=$1
home=/home/${user}

# create new user with root priviliges
useradd -d ${home} -s /bin/bash -m ${user}
adduser ${user} sudo

# copy ssh key for root user to admin
# root ssh key is created automatically by DigitalOcean
# when a new droplet is created
ssh=${home}/.ssh
keys=.ssh/authorized_keys
mkdir ${ssh}
chmod 700 ${ssh}
cp ${keys} ${home}/${keys}
chmod 600 ${home}/${keys}
chown -R ${user}:${user} ${ssh}

# install puppet
apt-get update
apt-get install -y puppet

# install required puppet modules
puppet module install puppetlabs-java
puppet module install amosjwood-neo4j

# copy local modules into installation
cp -r /tmp/puppet/modules/* /etc/puppet/modules

# apply puppet configuration
puppet apply /tmp/puppet/setup.pp

# disable password logins
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
echo "export EDITOR=/usr/bin/vim" >> /etc/environment

service ssh restart


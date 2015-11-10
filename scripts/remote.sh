#!/bin/bash

user=$1
home=/home/${user}

useradd -d ${home} -s /bin/bash -m ${user}
adduser ${user} sudo

ssh=${home}/.ssh
keys=.ssh/authorized_keys
mkdir ${ssh}
chmod 700 ${ssh}
cp ${keys} ${home}/${keys}
chmod 600 ${home}/${keys}
chown -R ${user}:${user} ${ssh}

apt-get update
apt-get install -y puppet

puppet module install puppetlabs-java
puppet module install amosjwood-neo4j

cp -r /tmp/puppet/modules/* /etc/puppet/modules
puppet apply /tmp/puppet/setup.pp

sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
echo "export EDITOR=/usr/bin/vim" >> /etc/environment

service ssh restart


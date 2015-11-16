#!/bin/bash

# you must run this script as root

# pull down churchill repo changes as node-user
repo=/home/node-user/churchill
su -c "git --git-dir=$repo/.git --work-tree=$repo pull origin master" node-user

# restart app
service churchill-node restart

#!/bin/bash

# ./configure.sh <host> <user>

DIR="$(cd "$(dirname "$0")" && pwd)"
PARENT="$(dirname "$DIR")"

host=$1
user=$2

if [[ -z "${host}" ]] || [[ -z "${user}" ]] ; then
    echo
    echo "Configure remote server with basics"
    echo
    echo "This program will run a remote shell script that will:"
    echo "  1. create a new <user> and add them to sudoers"
    echo "  2. add ssh key from root to <user>"
    echo "  3. change default editor to VIM"
    echo "  4. disable password-based ssh logins"
    echo
    echo "Usage: configure.sh <host> <user>"
    echo "  ./configure capstone.meyersj.com admin"
else
    # copy puppet files
    scp -r $PARENT/puppet root@${host}:/tmp

    # run remote setup script
    config_script=$DIR/remote.sh
    ssh root@${host} "bash -s" -- < ${config_script} ${user}
fi


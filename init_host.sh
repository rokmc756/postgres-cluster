#!/bin/sh
#
# initialize installation for Ansible on a given hosts
#
# written by: Andreas 'ads' Scherbaum <andreas@scherbaum.la>
# modified by: Jack Moon <rokmc756@gmail.com><jomoon@pivotal.io> for multiple gpdb hosts
#
# Usage:
#    ./init_host.sh <IP address> <user name>
#
# Note: NEVER use this script to init a host in an untrusted network!
#

set -e

if [ "$#" -ne 2 ];
then
    echo ""
    echo "Usage:"
    echo ""
    echo "$0 <IP address> <user name>"
    echo ""
    echo "Note: NEVER use this script to init a host in an untrusted network!"
    echo ""
    exit 1
fi

echo "scanning for old ssh keys, adding new keys to './known_hosts' file"
ssh-keyscan $1 >> ./known_hosts
awk '!x[$0]++' < ./known_hosts > ./known_hosts.tmp
cat ./known_hosts.tmp > ./known_hosts
rm -f ./known_hosts.tmp

echo "Pinging target host: $1"
ansible all --ssh-common-args='-o UserKnownHostsFile=./known_hosts -o VerifyHostKeyDNS=true' -m ping -i "$1," -u "$2"

#!/bin/bash

# This script will ssh into the first webserver EC2 instance in a VPC.
# 3 parameters are used:
#	DYNAMIC_HOST_FILE: Location of the ansible dynamic host file, this file requests AWS information.
#	FIRST_HOST_IP:  all the EC2 instances in the VPC are requested, and the first webserver is selected.
#	USERNAME: username is used which is entered as a CloudFormation parameter when creating the stack.
# This script can only be executed on the bastion host.
# Execute requirements: package 'jq' needs to be installed.

DYNAMIC_HOST_FILE=/etc/ansible/ec2.py

if [ -f $DYNAMIC_HOST_FILE ]; then
  FIRST_HOST_IP=$(${DYNAMIC_HOST_FILE} --list | jq -r '.tag_Role_Webserver[0]')
  USERNAME=$(sed -n -e 's/^login_name=//p' /etc/hsl.def)
  ssh ${USERNAME}@${FIRST_HOST_IP}
else
  echo "$DYNAMIC_HOST_FILE does not exist"
fi

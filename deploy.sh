#!/bin/bash

# last test
# This script will ssh into the first webserver and do an admin deployment, then a web deployment on all web servers.
# This script can only be executed on the bastion host from the folder aws-ansible.

ansible-playbook maintenance-enable.yml
ansible-playbook deploy-admin.yml -e flag1=--keep-maintenance
ansible-playbook deploy-webnode.yml -e flag1=--keep-maintenance
ansible-playbook maintenance-disable.yml

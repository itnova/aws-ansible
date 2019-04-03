#!/bin/bash

# This script will:
# - Enable maintenance
# - Fetch environment configuration from Github webshop_config repository
# - Deploys environment configuration on all servers
# - Ssh into the first webserver and do an admin deployment
# - Then a web deployment on all web servers..
# - Disable maintenance

# NOTE: if you don't want to use environment config deployment,
# please use the deploy.sh file instead

ansible-playbook maintenance-enable.yml
ansible-playbook fetch-application-environment-configuration.yml
ansible-playbook deploy-application-environment-file.yml
ansible-playbook deploy-admin.yml -e flag1=--keep-maintenance -e flag2=--composer
ansible-playbook deploy-webnode.yml -e flag1=--keep-maintenance -e flag2=--composer
ansible-playbook maintenance-disable.yml

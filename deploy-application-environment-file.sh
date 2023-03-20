#!/bin/bash

# This script will:
# - Pull the latest env.php file from the config repo
# - Push this env.php to all nodes
# - Import the new config

ansible-playbook fetch-application-environment-configuration.yml
ansible-playbook deploy-application-environment-file.yml
ansible-playbook deploy-config.yml

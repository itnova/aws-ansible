#!/bin/bash

# This script will:
# - Enable maintenance
# - pulls the latest changes from Github or checkouts a specific tag (passed with -t)
# - Fetches the latests environment config
# - Deploys the config changes on the bastion
# - Deploys js translations on all web nodes
# - Generate critical css on all web nodes

while getopts ":t:" opt; do
  case $opt in
    t) opt_tag="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

ansible-playbook maintenance-enable.yml
if [ "$opt_tag" ]
then
  echo "Tag $opt_tag will be checkout."
  ansible-playbook checkout-tag.yml -e tag=$opt_tag
else
  echo "One of the following parameters must be passed: -t"
  exit
fi

ansible-playbook fetch-application-environment-configuration.yml
ansible-playbook deploy-application-environment-file.yml
ansible-playbook deploy-config.yml
ansible-playbook deploy-js-translation.yml
ansible-playbook generate-critical-css.yml

# Run PWA if spstorefront directory exists
if [ -d ../httpdocs/spstorefront ]
then
  ansible-playbook fetch-pwa-environment-configuration.yml
  ansible-playbook deploy-pwa-environment-file.yml
  ansible-playbook deploy-pwa.yml
fi

ansible-playbook cache-flush.yml

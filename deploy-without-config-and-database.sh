#!/bin/bash

# This script will:
# - Enable maintenance
# - pulls the latest changes from Github or checkouts a specific tag (passed with -t)
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

if [ "$opt_tag" ]
then
  echo "Tag $opt_tag will be checkout."
  ansible-playbook checkout-tag.yml -e tag=$opt_tag
else
  echo "One of the following parameters must be passed: -t"
  exit
fi

ansible-playbook deploy-js-translation.yml
ansible-playbook generate-critical-css.yml

# Run PWA if spstorefront directory exists
if [ -d ../httpdocs/spstorefront ]
then
  echo "Deploy PWA"
  ansible-playbook fetch-pwa-environment-configuration.yml
  ansible-playbook deploy-pwa-environment-file.yml
  ansible-playbook deploy-pwa.yml
else
  echo "Skip PWA deploy"
fi

ansible-playbook cache-flush.yml

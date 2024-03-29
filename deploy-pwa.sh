#!/bin/bash

# This script will:
# - Pull the latest changes from Github or checkouts a specific tag (passed with -t)
# - Deploy the spstorefront (pwa) .env file from a shared repository
# - Deploy the spstorefront (pwa) application
# - Flush the cache

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

# Run PWA if spstorefront directory exists
if [ -d ../httpdocs/spstorefront ]
then
  echo "Deploy PWA"
  ansible-playbook fetch-pwa-environment-configuration.yml
  ansible-playbook deploy-pwa-environment-file.yml
  ansible-playbook deploy-pwa.yml
  ansible-playbook cache-flush.yml
else
  echo "Skip PWA deploy"
fi

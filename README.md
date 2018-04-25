# aws-ansible

# Ansible scripts usage:
ansible-playbook ansible-load-facts.yml

ansible-playbook cache-flush.yml

ansible-playbook deploy-admin.yml -e flag1=keep-maintenance -e flag2=no-git [flags are optional]

ansible-playbook deploy-webnode.yml -e flag1=keep-maintenance -e flag2=no-git [flags are optional]

ansible-playbook maintenance-allow-ips.yml -e flag1=<ip-address> [flag is mandatory]

ansible-playbook maintenance-disable.yml

ansible-playbook maintenance-enable.retry

ansible-playbook maintenance-enable.yml

ansible-playbook opcache-flush.yml

# Bash scripts usage:
./ec2-login.sh, will ssh to the first Webserver EC2 instance.

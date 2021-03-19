#!/bin/sh

# python
apt-get update
apt-get install -y python3
apt-get install -y python3-pip
apt-get install -y python3-venv
apt-get install -y python3-setuptools
python3 -m pip install --upgrade pip
python3 -m pip install ansible

# ansible
apt-get install software-properties-common
# apt-add-repository ppa:ansible/ansible
# apt-get update
# apt-get install -y ansible
# Bootstrapping steps. Here we create needed directories on the guest

mkdir -p ~/.ssh
mkdir -p ~/.ansible
mkdir -p ~/.config
mkdir -p ~/.config/openstack
mkdir -p /etc/ansible
ansible-galaxy collection install openstack.cloud
# python3 -m pip install python-openstackclient
python3 -m pip install openstacksdk --ignore-installed PyYAML

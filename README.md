# ansible-playbooks

This program uses the included Vagrantfile to spawn an local VM. 
This local VM will automatically run a variety of ansible playbooks from a master playbook to spawn VM2 and VM3 in chameleon cloud. 
The local VM will run the producer.py code, and VM2 will run consumer.py, which dumps the received contents into couchdb.
The data is viewable in the couchdb web console. 


To run: 

1. vagrant up
2. vagrant provision
3. vagrant destroy


Summary of files:

Vagrant File: 
Creates ubuntu virtual box
Runs shell provisioner bootstrap.sh script
Installs python, pip, ansible, creates needed directories (.ssh, .ansible, .config, etc.) and ansible-galaxy collection openstack.cloud
Copies local files to virtual machine to then get copied over for use by chameleons vms
Ansible.cfg, MyInventory, clouds.yml, consumer.py, kafka broker server.properties for vm2 and vm3, producer code and install_couchdb shell
Runs ansible provisioner 
Runs playbook_demo_master

Playbook_demo_master.yml runs the following: 

tasks/create_cloud_vms.yml
Creates vm2 and vm3 on chameleon cloud with the same IP addresses and required security groups

tasks/download_kafka.yml
Downloads kafka on the cloud vms and creates the required directories

tasks/copy_config_files_consumer_vm2.yml
Copies zookeeper properties and kafka server.properties file for vm2
Copies the consumer code into vm2

tasks/copy_config_files_vm3.yml
Copies the kafka server.properties file for vm3

tasks/enable_ufw_ports.yml
Allows port 9092, 2181, and 5984 for both chameleon vms

tasks/start_zookeeper.yml
Starts the zookeeper server on vm2

tasks/start_kafka_both_cloud.yml
Start kafka brokers on vm2 and vm3

tasks/install_couchdb.yml
Installs couchdb on vm3 by running shell command

tasks/run_producer.yml
Runs producer on vagrant created virtual machine (myLocalVMs)

tasks/start_consumer.yml
Downloads kafka-python, and downloads couchdb on vm2
Runs consumer code on vm2

tasks/delete_cloud_vms.yml
Deletes chameleon cloud vm2 and vm3
 
Additional Files: 
Clouds.yml file: helper file which is used by OpenStack tools as a source of configuration on how to connect to a cloud (in creation of vm2 and vm3)
Id_rsa: token to create/ssh into our vms
MyInventory

# ansible-playbooks Assignment 3 Full Documentation

This program uses the included Vagrantfile to spawn a local VM which will then run a variety of ansible playbooks from a master playbook to spawn VM2 and VM3 in chameleon cloud. 
The local VM will run the producer.py code, and VM2 will run consumer.py, which dumps the received contents into couchdb.
Zookeeper, Kafka, CouchDB and consumer.py all run in docker containers and are managed via Kubernetes. 
The data is viewable in the couchdb web console. 


# To run: 

1. vagrant up
2. vagrant destroy

to view data output to couchdb: http://129.114.27.202:5984/_utils/index.html

# Summary of files:

Vagrant File: 

Creates ubuntu virtual box
Runs shell provisioner bootstrap.sh script
Installs python, pip, ansible, creates needed directories (.ssh, .ansible, .config, etc.) and ansible-galaxy collection openstack.cloud
Copies local files to virtual machine to then get copied over for use by chameleons vms
Ansible.cfg, MyInventory, clouds.yml, consumer.py, kafka broker server.properties for vm2 and vm3, producer code and install_couchdb shell, all docker_kubernetes command shell scripts, and all deployment and service yaml files for the consumer, kakfa brokers, couchbd, and zookeeper
Runs ansible provisioner 
Runs playbook_demo_master

# Playbook_demo_master.yaml runs the following: 

tasks/create_cloud_vms.yaml
Creates vm2 and vm3 on chameleon cloud with the same IP addresses and required security groups

tasks/install_docker.yaml
runs the shell file: install_docker_kubernetes.sh on both chameleon VMs
- downloads docker, downloads kubernetes, and disables swap for kubernetes

tasks/enable_ufw_ports.yaml
Allows the following ports on both Chameleon VMs:
- 9092, 2181, 5984, 2379:2380/tcp,6443/tcp,10250:10252/tcp, 8285/udp, 8472/udp, 5000/tcp, 30000:30004/tcp, 30005/tcp, 30006/tcp

tasks/start_kubernetes_cluster.yaml
- starts kubeadm cluster, and runs the three required kubernetes commands, generates join command and copies it to a local file for VM3

tasks/taint_master_compile_dockerfiles.yaml
- copies all required shell files, server2 and server3 properties, the local.ini, docker files, consumer.py, and zookeeper properties
- taints master, applies flannel, runs docker, builds the required docker images, tags required docker images, and then pushes required docker images

tasks/join_cluster_vm3.yaml
- Vm3 joins cluster with command copied to local file (join_command)

tasks/copy_kubernetes_deployment_files.yaml
- copies over essential docker files, yaml files, and start_deployments_services shell file to VM2

tasks/start_deployments_services.yaml
- runs all service and deployment yaml files (zookeeper, kafka broker0 and broker1, couchbd, consumer) with kubectl apply command

tasks/stop_deployments_services.yaml
- stops all service and deployment yaml files (zookeeper, kafka broker0 and broker1, couchbd, consumer) with kubectl delete command
 
tasks/delete_cloud_vms.yaml
 - deletes the two cloud vm instances
 
# Additional Files: 
- Clouds.yml file: helper file which is used by OpenStack tools as a source of configuration on how to connect to a cloud (in creation of vm2 and vm3)
- Id_rsa: token to create/ssh into our vms
- MyInventory

# Docker Files: 
- consumer_deployment.yaml
- consumer_docker
- couchdb_deployment.yaml
- couchdb_service.yaml
- just_couchdb_docker
- kafka_broker0_deployment.yaml
- kafka_broker0_service.yaml
- kafka_broker1_deployment.yaml
- kafka_broker1_service.yaml
- kafka_couchdb_docker
- zookeeper_deployment.yaml
- zookeeper_service.yaml
- kubernetes_dir.sh

# Summary of work breakdown: 

- Milestone 1: Kaleab
- Milestone 2: Kaleab
- Milestone 3: Maddie and Kaleab
- Documentation/Submissions: Maddie

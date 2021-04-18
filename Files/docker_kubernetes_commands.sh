
# after installing docker and starting kubernetes cluster
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#################################################

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

#################################################

kubectl taint nodes kubemaster node-role.kubernetes.io/master:NoSchedule-

#################################################
sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2

# build docker images and push them into the private registry
sudo docker build -f ~/consumer_docker -t my-consumer .
sudo docker build -f ~/kafka_couchdb_docker -t my-kafka-couchdb .
sudo docker build -f ~/just_couchdb_docker -t just-couchdb .

sudo docker tag my-consumer:latest 129.114.25.102:5000/my-consumer
sudo docker tag my-kafka-couchdb:latest 129.114.25.102:5000/my-kafka-couchdb
sudo docker tag just-couchdb:latest 129.114.25.102:5000/just-couchdb

sudo docker push 129.114.25.102:5000/my-consumer
sudo docker push 129.114.25.102:5000/my-kafka-couchdb
sudo docker push 129.114.25.102:5000/just-couchdb



## start kubeadm init cluster
## get the join token to the worker somehow
## run a playbook to run the join command on VM3
## on vm2, run the service

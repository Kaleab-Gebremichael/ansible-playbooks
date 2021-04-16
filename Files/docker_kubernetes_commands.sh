
# after installing docker and kubernetes
sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2


# build docker images and push them into the private registry
sudo docker build -f ./consumer_docker -t my-consumer .
sudo docker build -f ./kafka_couchdb_docker -t my-kafka-couchdb .

sudo docker tag my-consumer:latest 129.114.25.102:5000/my-consumer
sudo docker tag my-kafka-couchdb:latest 129.114.25.102:5000/my-kafka-couchdb

sudo docker push 129.114.25.102:5000/my-consumer
sudo docker push 129.114.25.102:5000/my-kafka-couchdb


sudo kubeadm init --node-name kubemaster -pod-network-cidr=10.244.0.0/16

kubectl apply -f /home/cc/zookeeper_service.yaml
sleep 5
kubectl apply -f /home/cc/zookeeper_deployment.yaml
sleep 5
kubectl apply -f /home/cc/kafka_broker0_service.yaml
sleep 5
kubectl apply -f /home/cc/kafka_broker0_deployment.yaml
sleep 5
kubectl apply -f /home/cc/kafka_broker1_service.yaml
sleep 5
kubectl apply -f /home/cc/kafka_broker1_deployment.yaml
sleep 5
kubectl apply -f /home/cc/couchdb_service.yaml
sleep 5
kubectl apply -f /home/cc/couchdb_deployment.yaml
sleep 15


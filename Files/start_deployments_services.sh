kubectl apply -f ~/zookeeper_service.yaml
sleep 5
kubectl apply -f ~/zookeeper_deployment.yaml
sleep 5
kubectl apply -f ~/kafka_broker0_service.yaml
sleep 5
kubectl apply -f ~/kafka_broker0_deployment.yaml
sleep 5
kubectl apply -f ~/kafka_broker1_service.yaml
sleep 5
kubectl apply -f ~/kafka_broker1_deployment.yaml
sleep 5
kubectl apply -f ~/couchdb_service.yaml
sleep 5
kubectl apply -f ~/couchdb_deployment.yaml
sleep 5
kubectl apply -f ~/consumer_deployment.yaml

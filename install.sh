#!/bin/bash

export KAFKA_NS=kafka
/Users/paul.vergilis@konghq.com/workspace/github/deploy-strimzi/kafka
echo "Deploying Kafka - Creating Namespace"
echo \
"apiVersion: v1
kind: Namespace
metadata:
  name: $KAFKA_NS
  namespace: $KAFKA_NS"| kubectl apply -f -

helm repo add strimzi https://strimzi.io/charts/
helm repo update

echo "Deploying Kafka - Installing Strimzi Operator"

helm install strimzi strimzi/strimzi-kafka-operator --namespace $KAFKA_NS

echo "Deploying Kafka - Creating cluster"
kubectl apply -f ./kafka/kafka.yaml -n $KAFKA_NS

echo "Deploying Kafka - Waiting for cluster to come up"
kubectl wait kafka/my-cluster --for=condition=Ready --timeout=300s -n $KAFKA_NS

echo "Deploying Kafka - Creating topic"
kubectl apply -f ./kafka/kafka-topic.yaml -n $KAFKA_NS



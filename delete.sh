#!/bin/sh

export KAFKA_NS=kafka

echo "Deleting Kafka - Deleting Strimzi Operator"

helm delete strimzi -n $KAFKA_NS

echo "Deleting Kafka - Deleting cluster"
kubectl delete -f ./kafka/kafka.yaml -n $KAFKA_NS

echo "Deleting Kafka - Deleting topic"
kubectl delete -f ./kafka/kafka-topic.yaml -n $KAFKA_NS

kubectl delete ns $KAFKA_NS
#!/bin/bash

# Logs a message with a timestamp
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Retrieves the Kafka cluster ID from the REST API
get_kafka_cluster_id() {
    KAFKA_CLUSTER_ID=$(curl -s -X GET "http://localhost:8090/v1/metadata/id" | awk -F '"' '/"id":/ {print $4}')
    echo "$KAFKA_CLUSTER_ID"
}
#!/bin/bash
set -e

source ./scripts/utils.sh

trap 'log "An error occurred on line $LINENO. Terminating script." && exit 1' ERR

log "Starting containers 'broker' and 'confluent-cli'..."
docker compose up -d broker confluent-cli

log "Disabling feature flags via Confluent CLI..."
docker compose exec -T confluent-cli bash -c "yes Y | confluent configuration update disable_feature_flags true"

log "Creating role bindings..."
./scripts/create-role-bindings.sh

log "Creating Kafka topic 'orders'..."
docker compose exec -T confluent-cli bash -c "confluent kafka topic create orders --partitions 1 --replication-factor 1 --url http://broker:8090/kafka"

log "Starting container 'control-center'..."
docker compose up -d control-center

log "Script executed successfully."
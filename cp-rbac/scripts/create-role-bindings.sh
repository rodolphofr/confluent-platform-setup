#!/bin/bash
set -e

source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

CLUSTER_ID=$(get_kafka_cluster_id)

#################### Login MDS ####################
log "Login to MDS"
docker compose exec -T confluent-cli bash -c "confluent login --save --no-browser"

#################### Create Role Bindings - SUPER USER ####################
log "Creating role binding for superUser"
docker compose exec -T confluent-cli bash -c "confluent iam rbac role-binding create --principal User:superUser --role SystemAdmin --kafka-cluster ${CLUSTER_ID}"

#################### Create Role Bindings - CONTROL CENTER ####################
log "Creating role binding for controlcenter"
docker compose exec -T confluent-cli bash -c "confluent iam rbac role-binding create --principal User:controlcenter --role SystemAdmin --kafka-cluster ${CLUSTER_ID}"

#################### Create Role Bindings - DEVELOPERS ####################
log "Creating role binding \"DeveloperRead\" for developers"
docker compose exec -T confluent-cli bash -c "confluent iam rbac role-binding create --principal User:harry --role DeveloperRead --resource Topic:orders --kafka-cluster ${CLUSTER_ID}"
docker compose exec -T confluent-cli bash -c "confluent iam rbac role-binding create --principal User:grace --role DeveloperRead --resource Topic:orders --kafka-cluster ${CLUSTER_ID}"
docker compose exec -T confluent-cli bash -c "confluent iam rbac role-binding create --principal User:harry --role DeveloperRead --resource Group:console-consumer --kafka-cluster ${CLUSTER_ID}"
docker compose exec -T confluent-cli bash -c "confluent iam rbac role-binding create --principal User:grace --role DeveloperRead --resource Group:console-consumer --kafka-cluster ${CLUSTER_ID}"

log "Creating role binding \"DeveloperWrite\" for developers"
docker compose exec -T confluent-cli bash -c "confluent iam rbac role-binding create --principal User:harry --role DeveloperWrite --resource Topic:orders --kafka-cluster ${CLUSTER_ID}"
docker compose exec -T confluent-cli bash -c "confluent iam rbac role-binding create --principal User:harry --role DeveloperWrite --resource Topic:orders --kafka-cluster ${CLUSTER_ID}"
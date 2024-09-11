#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source ${DIR}/functions.sh

check_prerequisites
delete_cluster

docker system prune -f
docker builder prune -f

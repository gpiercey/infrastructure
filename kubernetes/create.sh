#!/usr/bin/env bash

set -e

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source ${DIR}/functions.sh

docker system prune -f
docker builder prune -f

check_prerequisites
create_cluster
install_nginx
install_metrics_server
install_dashboard "${USER}"
install_echo
generate_dashboard_token "${USER}"

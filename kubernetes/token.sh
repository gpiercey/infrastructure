#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source ${DIR}/functions.sh

generate_dashboard_token "${USER}"

#!/usr/bin/env bash

NAME=ubuntu-openjdk
TAG=latest
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

docker build -f "${SCRIPT_DIR}/Dockerfile" -t ${NAME}:${TAG} --no-cache "${SCRIPT_DIR}"
docker system prune -f
docker builder prune -f

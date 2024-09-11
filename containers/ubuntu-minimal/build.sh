#!/usr/bin/env bash

NAME=ubuntu-minimal
TAG=24.04
URL=https://partner-images.canonical.com/oci/noble/current/ubuntu-noble-oci-amd64-root.tar.gz
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
ROOT="$(basename ${URL})"

[ ! -f "${SCRIPT_DIR}/${ROOT}" ] && wget -P "${SCRIPT_DIR}" ${URL}

docker build -f "${SCRIPT_DIR}/Dockerfile" -t ${NAME}:${TAG} --build-arg ROOT="${ROOT}" --no-cache "${SCRIPT_DIR}"
docker tag ${NAME}:${TAG} ${NAME}:latest

docker system prune -f
docker builder prune -f

rm -f "${SCRIPT_DIR}/${ROOT}"

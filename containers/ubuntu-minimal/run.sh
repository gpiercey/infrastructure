#!/usr/bin/env bash

NAME=ubuntu-minimal
TAG=latest

docker run --rm -it --name ${NAME} --hostname ${NAME} ${NAME}:${TAG} "$@"

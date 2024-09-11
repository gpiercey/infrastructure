#!/usr/bin/env bash

NAME=ubuntu-openjdk
TAG=latest

docker run --rm -it --name ${NAME} --hostname ${NAME} ${NAME}:${TAG} "$@"

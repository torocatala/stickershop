#!/bin/bash

usage() {
    echo "Invalid service name or no arguments supplied"
    echo "Usage: ./docker_exec.sh {frontend|jsbackend|rbbackend}"
    exit 1
}

if [ $# -eq 0 ]
  then
    usage
fi

service=$1

if [ "$service" == "frontend" ] || [ "$service" == "jsbackend" ] || [ "$service" == "rbbackend" ]
  then
    container_id=$(docker compose ps -q $service)
    docker exec -it $container_id /bin/bash
  else
    usage
fi

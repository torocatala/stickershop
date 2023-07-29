#!/bin/bash

# get container id of the rbbackend service
container_id=$(docker-compose ps -q rbbackend)

# if the container is not running, start it
if [ -z "$container_id" ]; then
  echo "Container not found, please start the app or check the service name"
  exit
fi

echo "Running tests in rbbackend service..."

# run tests
docker exec -t $container_id rails test

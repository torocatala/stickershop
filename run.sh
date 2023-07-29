#!/bin/bash
reset
# Check for Docker 
if ! command -v docker &> /dev/null; then
  echo "Docker is required to run stickershop. Please install Docker and try again."
  exit 1
fi

# Check for Docker Compose
if ! command -v docker-compose &> /dev/null; then
  echo "Docker Compose is required to run stickershop. Please install Docker Compose and try again."
  exit 1 
fi

# Stop the app
echo "Stopping stickershop..."
docker-compose down

#Clean
docker rm -f $(docker ps -qa) 2>/dev/null
docker volume rm $(docker volume ls -q) 2>/dev/null
rm -f rbbackend/tmp/pids/server.pid

# Start the app
echo "Starting stickershop..."
docker-compose up -d --force-recreate

# Check if the app started successfully 
echo "Waiting for stickershop to start..."
until curl -s http://localhost:3000; do
  sleep 1 
done
echo "Stickershop started successfully at http://localhost:3000"

# View logs
echo "To view logs, run:" 
echo "  docker-compose logs -f"

# Stop the app
echo "To stop stickershop app, run:"
echo "  docker-compose down"

docker ps -a

docker logs stickershop-rbbackend-1
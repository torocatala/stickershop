#!/bin/bash
reset

# Check for Docker 
if ! command -v docker &> /dev/null; then
  echo "Docker is required to run stickershop. Please install Docker and try again."
  exit 1
fi

#Clean
echo "Cleaning the environment..."
docker rm -f $(docker ps -qa) 2>/dev/null
docker volume rm $(docker volume ls -q) 2>/dev/null
rm -f rbbackend/tmp/pids/server.pid 2>/dev/null
echo ""

# Start the app
echo "Starting stickershop..."
docker-compose up -d --force-recreate
echo ""

# Check if the app started successfully 
echo "Waiting for stickershop sytem to start..."
until curl -s http://localhost:3000 > /dev/null; do
  sleep 1 
done
echo "Stickershop frontend started successfully at http://localhost:3000"
until curl -s http://localhost:3001 > /dev/null; do
  sleep 1 
done
echo "Stickershop ruby backend started successfully at http://localhost:3001"
echo ""

# Useful info
echo "To view logs, run:" 
echo "  docker-compose logs -f"
echo ""

docker ps -a
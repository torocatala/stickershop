#!/bin/bash
reset

# Check for Docker 
if ! command -v docker &> /dev/null; then
  echo "Docker is required to run stickershop. Please install Docker and try again."
  exit 1
fi

# Clean environment
echo "Cleaning the environment..."
rm -f rbbackend/tmp/pids/server.pid 2>/dev/null
echo ""

# Set environment variables
# (in some systems and shells, these might not be exported to child processes (like Docker Compose) by default.)
export UID=$(id -u) 2>/dev/null
export GID=$(id -g) 2>/dev/null

if git diff --quiet --exit-code frontend/package.json; then
  echo "No changes detected in frontend/package.json. Using existing Docker image."
else
  echo "Changes detected in package.json. Rebuilding the Docker image..."
  docker-compose build frontend
fi
if git diff --quiet --exit-code rbbackend/Gemfile; then
  echo "No changes detected in frontend/Gemfile. Using existing Docker image."
else
  echo "Changes detected in Gemfile. Rebuilding the Docker image..."
  docker-compose build rbbackend
fi

# Start the app
echo "Starting stickershop..."
docker-compose up -d --force-recreate
echo ""

# Check if the app started successfully 
echo "Waiting for stickershop system to start..."
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
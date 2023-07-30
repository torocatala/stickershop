#!/bin/bash
reset

wait_for_service() {
  local service_name=$1
  local service_url=$2

  echo "Waiting for ${service_name} to start..."

  local attempt_counter=0
  local max_attempts=10

  until $(curl --output /dev/null --silent --head --fail ${service_url}) || [ ${attempt_counter} -eq ${max_attempts} ]; do
    printf '.'
    attempt_counter=$((${attempt_counter}+1))
    sleep 1
  done

  if [ ${attempt_counter} -eq ${max_attempts} ]; then
    echo "Max attempts reached for ${service_name}, failing..."
    docker compose logs "$service_name"
    exit 1
  fi

  echo "${service_name} system started!"
}

check_file_changes() {
  local service=$1
  local filename=$2

  if git diff --quiet --exit-code ${filename}; then
    echo "No changes detected in ${filename}. Using existing Docker image for ${service}."
  else
    echo "Changes detected in ${filename}. Rebuilding the Docker image for ${service}..."
    docker compose build ${service}
  fi
}


# Check for Docker 
if ! command -v docker &> /dev/null; then
  echo "Docker is required to run stickershop. Please install Docker and try again."
  exit 1
fi

# Clean environment
echo "Cleaning the environment..."
rm -f rbbackend/tmp/pids/server.pid 2>/dev/null
echo ""

# Check for .env file
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Set environment variables
# (in some systems and shells, these might not be exported to child processes (like Docker Compose) by default.)
export UID=$(id -u) 2>/dev/null
export GID=$(id -g) 2>/dev/null

# Check for changes in project dependencies and recreate images if needed
check_file_changes "frontend" "frontend/package.json"
check_file_changes "rbbackend" "rbbackend/Gemfile"

# Start the app
echo "Starting stickershop..."
docker compose up -d --force-recreate
echo ""

# Init Database
echo "Initializing the database if necessary..."
./exec.sh rbbackend "bin/rails db:create" 2>&1 >/dev/null

# Check if the app started successfully 
wait_for_service "frontend" "http://localhost:3000"
wait_for_service "rbbackend" "http://localhost:3001"
echo ""

# Useful info
echo "To view logs, run:"
echo "  docker compose logs -f"
echo ""

docker ps -a
#!/bin/bash
set -e

# Stop and remove existing Docker container
containerid=$(docker ps -q --filter "name=online-shop-container")
if [ -n "$containerid" ]; then
  echo "Stopping and removing existing container..."
  docker stop $containerid && docker rm -f $containerid
else
  echo "No running container found."
fi

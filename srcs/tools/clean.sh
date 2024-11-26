#!/bin/bash

echo "Stop and remove all containers..."
docker stop $(docker ps -qa)
docker rm $(docker ps -qa)

echo "Remove all volumes..."
docker volume rm $(docker volume ls -q)

echo "Remove all images..."
docker rmi -f $(docker images -qa)

echo "Remove all networks..."
docker network rm $(docker network ls -q)

echo "Docker clean done!"
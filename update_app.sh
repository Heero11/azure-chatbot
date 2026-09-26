#!/bin/bash

cd /home/azureuser/stage7

docker-compose pull
docker-compose up -d
docker image prune -f
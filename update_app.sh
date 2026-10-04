#!/bin/bash

cd /home/azureuser/azure-chatbot

docker-compose pull
docker-compose up -d
docker image prune -f
echo "Deployment completed successfully"
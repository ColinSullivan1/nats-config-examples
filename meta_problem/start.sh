#!/bin/sh

docker network create backbone

cd v0
docker compose up &

# sleep 1 
echo "Expanding cluster" 

cd ../v1
docker compose up &


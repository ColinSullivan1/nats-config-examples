#!/bin/sh

cd v0
docker compose up &

# sleep 1 
echo "Expanding cluster" 

cd ../v1
docker compose up &


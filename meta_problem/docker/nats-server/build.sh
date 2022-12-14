#!/bin/sh

docker build --platform linux/amd64 -t colin/nats-server --no-cache .


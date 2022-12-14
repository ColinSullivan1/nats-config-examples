#!/bin/bash

echo "nats server report jetstream --server=n1m1 --user=admin --password=admin"

docker run --network backbone --rm -it natsio/nats-box


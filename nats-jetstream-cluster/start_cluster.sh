#!/bin/sh

mkdir -p logs
rm logs/* 2>/dev/null


nats-server -config conf/server_a.conf &
nats-server -config conf/server_b.conf &
nats-server -config conf/server_c.conf &


#!/bin/sh

nats-server -c central.conf &
nats-server -c regional.conf &
nats-server -c edge.conf &
nats-server -c device.conf &

#!/bin/sh

nats-streaming-server --config nss.conf &
nats-streaming-server --config nss2.conf &
docker run --rm -p 7777:7777 synadia/prometheus-nats-exporter -connz -varz -serverz -channelz http://192.168.0.6:8222/ &
prometheus --config.file="p.yml" --web.listen-address="0.0.0.0:9090"  


#!/bin/sh

nats-streaming-server --config nss.conf -DV &
docker run --rm -p 7778:7777 synadia/prometheus-nats-exporter -connz -varz -serverz -channelz http://192.168.0.6:8223/ &
prometheus --config.file="p.yml" --web.listen-address="0.0.0.0:9091"  


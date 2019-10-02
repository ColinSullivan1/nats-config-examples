#!/bin/sh

echo '
global:
  scrape_interval: 5s
  evaluation_interval: 5s

scrape_configs:
  - job_name: prometheus

    static_configs:
    - targets: ["localhost:7777"]
      labels:
        pod: "nats-0"
' | sudo tee /tmp/px.yml

docker run --rm -p 9990:9090 -v /tmp/px.yml:/etc/prometheus/prometheus.yml prom/prometheus


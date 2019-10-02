#!/bin/sh

echo '
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: event-horizon
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: event-horizon
    spec:
      volumes:
      - name: active-stan-config
        secret:
          secretName: active-stan-secret
          items: 
          - key: active-stan-secret.conf
            path: active-stan-secret.conf
      containers:
      - name: event-horizon-active
        volumeMounts:
          - name: active-stan-config
            mountPath: /etc/stan
        image: registry.hub.docker.com/library/nats-streaming
        imagePullPolicy: Always
        env:
        - name: region
          value: "EAST-US"
        args:
        - "-sc=/etc/stan/active-stan-secret.conf"    
' | kubectl apply -f -

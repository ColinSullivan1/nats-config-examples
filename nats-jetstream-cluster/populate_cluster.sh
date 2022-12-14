#!/bin/sh

nats s rm -f --user u --password p s1
nats s rm -f --user u --password p s2
nats s rm -f --user u --password p s3
nats s rm -f --user u --password p s4
nats s rm -f --user u --password p s5

echo '{ "name":"s1", "subjects":["s1"], "retention":"limits", "max_consumers":-1, "max_msgs":1000000, "max_bytes":-1, "max_age":0, "max_msg_size":-1, "storage":"file", "discard":"old", "num_replicas": 3 }' > tmp.json
nats --user u --password p stream create --config=tmp.json 
sleep 3

echo '{ "name":"s2", "subjects":["s2"], "retention":"limits", "max_consumers":-1, "max_msgs":1000000, "max_bytes":-1, "max_age":0, "max_msg_size":-1, "storage":"file", "discard":"old", "num_replicas": 3 }' > tmp.json
nats --user u --password p stream create --config=tmp.json 
sleep 3

echo '{ "name":"s3", "subjects":["s3"], "retention":"limits", "max_consumers":-1, "max_msgs":1000000, "max_bytes":-1, "max_age":0, "max_msg_size":-1, "storage":"file", "discard":"old", "num_replicas": 3 }' > tmp.json
nats --user u --password p stream create --config=tmp.json 
sleep 3

echo '{ "name":"s4", "subjects":["s4"], "retention":"limits", "max_consumers":-1, "max_msgs":1000000, "max_bytes":-1, "max_age":0, "max_msg_size":-1, "storage":"file", "discard":"old", "num_replicas": 3 }' > tmp.json
nats --user u --password p stream create --config=tmp.json 
sleep 3

echo '{ "name":"s5", "subjects":["s5"], "retention":"limits", "max_consumers":-1, "max_msgs":1000000, "max_bytes":-1, "max_age":0, "max_msg_size":-1, "storage":"file", "discard":"old", "num_replicas": 3 }' > tmp.json
nats --user u --password p stream create --config=tmp.json 

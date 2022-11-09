#!/bin/sh

echo '{ "name":"s1", "subjects":["s1"], "retention":"limits", "max_consumers":-1, "max_msgs":1000000, "max_bytes":-1, "max_age":0, "max_msg_size":-1, "storage":"file", "discard":"old", "num_replicas": 3 }' > tmp.json
nats --user u --password p stream create --config=tmp.json 

echo '{ "name":"s2", "subjects":["s2"], "retention":"limits", "max_consumers":-1, "max_msgs":1000000, "max_bytes":-1, "max_age":0, "max_msg_size":-1, "storage":"file", "discard":"old", "num_replicas": 3 }' > tmp.json
nats --user u --password p stream create --config=tmp.json 

echo '{ "name":"s3", "subjects":["s3"], "retention":"limits", "max_consumers":-1, "max_msgs":1000000, "max_bytes":-1, "max_age":0, "max_msg_size":-1, "storage":"file", "discard":"old", "num_replicas": 3 }' > tmp.json
nats --user u --password p stream create --config=tmp.json 

#!/bin/sh

nats-rply -t -s "localhost:4000" --creds ./auth/nkeys/creds/myoperator/myaccount/myuser.creds help "here's some help" &


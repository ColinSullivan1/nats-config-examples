#!/bin/bash

nats --creds user.creds sub "\$JS.EVENT.ADVISORY.STREAM.>"


#!/bin/bash

kill `ps -aef | grep "nats-server.*region" | cut -c6-12` 2>/dev/null

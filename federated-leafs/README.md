# Federated Leafs

This example demonstrates a chain of four leaf nodes.

## Setup

For demonstration purposes, here are four servers representing four layers
of a deployment.  The servers are leafed to create
a hierarchy or chain.  

This allows messages to flow as follows:

Device -> Edge -> Regionals -> Central

We'll generate data from the device, subscribe on the central,
and see messages flow across the chain.  This is entirely run on
a single node (my laptop),so ports will differentiate function.

Note that messages can flow in either direction with this 
configuration. Accounts can be setup to to restrict
data flow.

## Ports

| Layer   | Client | Monitor | Leaf (accept) | Leaf (solicit) |
|---------|--------|---------|---------------|----------------|
| Central |**4222**|  8222   |  7422         | N/A            |
| Regional|  4322  |  8322   |  7522         | 7422           |
| Edge    |  4422  |  8422   |  7622         | 7522           |
| Device  |**4522**|  8222   |  N/A          | 7622           |


## Security

None at this time, this demonstrates plumbing only.

## Example

You'll need a copy of the [NATS cli](https://github.com/nats-io/natscli)
From this repo directory:

### Launch the servers
```bash
$ ./run_servers.sh
```

### Launch a Consuming Application

Open a terminal and subscribe to the "Central" (port 4222) simulating an
application that will IoT data centrally in the cloud or datacenter.

```text
$ nats sub -s localhost:4222 "sensor.data"
```

### Simulate Generation of Sensor Data

Open a 2nd terminal and publish to the "device" (port 4522), simulating IoT sensor
data.  

```bash
$ nats pub -s localhost:4522 "sensor.data" "value1"
```

### Expected Output

#### Terminal with nats pub

```text
$ nats pub -s localhost:4322 "sensor.data" "value1"
15:21:35 Published 6 bytes to "sensor.data"
```

#### Terminal with nats sub

```text
 $ nats sub -s localhost:4222 "sensor.data"
15:21:31 Subscribing on sensor.data
[#1] Received on "sensor.data"
value1
```




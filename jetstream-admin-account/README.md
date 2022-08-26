# A Simple JetStream Administration Account

Some users prefer to administer NATS JetStream from a single "admin" account;
in fact it's been a somewhat common request. This example demonstrates a very simple setup to do that.

## Overview

There are three accounts configured `ACCOUNT_A` and `ACCOUNT_B` which represent accounts used by applications, and an `ADMIN_ACCOUNT` used by a JetStream administrator to administer JetStream assets in the other
accounts.

Configuration is found in the [simple_js_admin.conf](./simple_js_admin.conf) file.

### Requirements to run this example
 - [NATS Server](https://docs.nats.io/running-a-nats-service/introduction/installation)
 - [NATS CLI tool](https://docs.nats.io/running-a-nats-service/clients#installing-the-nats-cli-tool)

## User/Team/Application Account Configuration

These a simply accounts that have JetStream enabled and
expose the JetStream API as a service, allowing an admin account to 
fully administrate JetStream assets.

In the [simple_js_admin.conf](./simple_js_admin.conf) configuration file,
notice the export.

```text
    exports [ { service: "$JS.API.>"} ]
```

This exposes the JetStream admin API as a service to other accounts
(in this example just the `ADMIN_ACCOUNT`).

## Admin Account Configuration

The admin account imports the $JS.API services and adds a prefix for context. This allows tooling or NATS client SDKs to to specify which account to operate on when performing JetStream administrative operations.

Note the imports with prefixes:

```text
    imports [
      { service: { account: JETSTREAM_ACCOUNT_A, subject: "$JS.API.>"}, to: "ACCOUNT_A.JS.API.>" },
      { service: { account: JETSTREAM_ACCOUNT_B, subject: "$JS.API.>"}, to: "ACCOUNT_B.JS.API.>" }
    ]
```

## Administering JetStream

Let's first start the NATS server.  From this directory, run:

```bash
$ nats-server -config simple_js_admin.conf
```

You should see the server start and a banner.

Next, let's create a stream using the NATS cli.  User the username `js_admin` specifies that using the ADMIN account.  Note the prefix parameter `--js-api-prefix=ACCOUNT_A.JS.API` which specifies that we're creating 
a stream in `ACCOUNT_A`.

```bash
$ nats --user=js_admin --password=password --js-api-prefix=ACCOUNT_A.JS.API  s create foo
? Subjects foo
? Storage file
? Replication 1
? Retention Policy Limits
? Discard Policy Old
? Stream Messages Limit -1
? Per Subject Messages Limit -1
? Total Stream Size -1
? Message TTL -1
? Max Message Size -1
? Duplicate tracking time window 2m0s
? Allow message Roll-ups No
? Allow message deletion Yes
? Allow purging subjects or the entire stream Yes
Stream foo was created

Information for Stream foo created 2022-08-26T10:25:22-06:00

Configuration:

             Subjects: foo
     Acknowledgements: true
            Retention: File - Limits
             Replicas: 1
       Discard Policy: Old
     Duplicate Window: 2m0s
    Allows Msg Delete: true
         Allows Purge: true
       Allows Rollups: false
     Maximum Messages: unlimited
        Maximum Bytes: unlimited
          Maximum Age: unlimited
 Maximum Message Size: unlimited
    Maximum Consumers: unlimited


State:

             Messages: 0
                Bytes: 0 B
             FirstSeq: 0
              LastSeq: 0
     Active Consumers: 0
```

Now we'll create a stream on `ACCOUNT_B`.  Note the prefix.  

```bash
$ nats --user=js_admin --password=password --js-api-prefix=ACCOUNT_B.JS.API  s create bar
? Subjects bar
? Storage file
? Replication 1
? Retention Policy Limits
? Discard Policy Old
? Stream Messages Limit -1
? Per Subject Messages Limit -1
? Total Stream Size -1
? Message TTL -1
? Max Message Size -1
? Duplicate tracking time window 2m0s
? Allow message Roll-ups No
? Allow message deletion Yes
? Allow purging subjects or the entire stream Yes
Stream bar was created

Information for Stream bar created 2022-08-26T10:28:01-06:00

Configuration:

             Subjects: bar
     Acknowledgements: true
            Retention: File - Limits
             Replicas: 1
       Discard Policy: Old
     Duplicate Window: 2m0s
    Allows Msg Delete: true
         Allows Purge: true
       Allows Rollups: false
     Maximum Messages: unlimited
        Maximum Bytes: unlimited
          Maximum Age: unlimited
 Maximum Message Size: unlimited
    Maximum Consumers: unlimited


State:

             Messages: 0
                Bytes: 0 B
             FirstSeq: 0
              LastSeq: 0
     Active Consumers: 0
```

From here, we can add/remove/update streams and consumers in other accounts using the `js_admin` user.

## Expanding on This Example

Once this pattern is working in your environment, explore buttoning down
security further by making subsets of the [API operations](https://docs.nats.io/reference/reference-protocols/nats_api_reference#admin-api) individual
services. You can get as granular as allowing certain API actions on
specific streams or consumers.

Futhermore, the user/team/application accounts can be restricted from accessing the JetStream API (or subsets of the API) to button down
management with deny clauses.

Also, a configuration file with cleartext passwords is used in the 
interest of simplicity. In practice, it is highly recommended to instead
use [NATS 2.0 authorization](https://docs.nats.io/running-a-nats-service/nats_admin/security/jwt#tooling-and-key-management) (aka operator mode).

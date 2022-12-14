# Instructions

From this directory run `./start.sh`

If it start up OK run `./stop.sh` and repeat until you see:

```text
n2m1_1  | [1] 2022/12/01 21:47:09.535871 [INF] JetStream cluster new metadata leader: n1m1/NATS
n1m2_1      | [1] 2022/12/01 21:47:12.536178 [INF] JetStream cluster new metadata leader: n1m1/NATS
n2m1_1  | [1] 2022/12/01 21:47:12.536263 [INF] JetStream cluster new metadata leader: n1m1/NATS
```

run `./natscli.sh` and execute the echoed command:

```text
nats server report jetstream --server=n1m1 --user=admin --password=admin
```

Output

```text
$ ./runcli.sh 
nats server report jetstream --server=n1m1 --user=admin --password=admin
             _             _               
 _ __   __ _| |_ ___      | |__   _____  __
| '_ \ / _` | __/ __|_____| '_ \ / _ \ \/ /
| | | | (_| | |_\__ \_____| |_) | (_) >  < 
|_| |_|\__,_|\__|___/     |_.__/ \___/_/\_\
                                           
nats-box v0.13.2
1708da17515f:~# nats server report jetstream --server=n1m1 --user=admin --password=admin
╭───────────────────────────────────────────────────────────────────────────────────────────────╮
│                                       JetStream Summary                                       │
├────────┬─────────┬─────────┬───────────┬──────────┬───────┬────────┬──────┬─────────┬─────────┤
│ Server │ Cluster │ Streams │ Consumers │ Messages │ Bytes │ Memory │ File │ API Req │ API Err │
├────────┼─────────┼─────────┼───────────┼──────────┼───────┼────────┼──────┼─────────┼─────────┤
│ n1m1*  │ NATS    │ 0       │ 0         │ 0        │ 0 B   │ 0 B    │ 0 B  │ 0       │ 0       │
│ n2m1   │ NATS    │ 0       │ 0         │ 0        │ 0 B   │ 0 B    │ 0 B  │ 0       │ 0       │
│ n2m2*  │ NATS    │ 0       │ 0         │ 0        │ 0 B   │ 0 B    │ 0 B  │ 0       │ 0       │
│ n1m2   │ NATS    │ 0       │ 0         │ 0        │ 0 B   │ 0 B    │ 0 B  │ 0       │ 0       │
│ n1m3   │ NATS    │ 0       │ 0         │ 0        │ 0 B   │ 0 B    │ 0 B  │ 0       │ 0       │
├────────┼─────────┼─────────┼───────────┼──────────┼───────┼────────┼──────┼─────────┼─────────┤
│        │         │ 0       │ 0         │ 0        │ 0 B   │ 0 B    │ 0 B  │ 0       │ 0       │
╰────────┴─────────┴─────────┴───────────┴──────────┴───────┴────────┴──────┴─────────┴─────────╯

╭─────────────────────────────────────────────────╮
│           RAFT Meta Group Information           │
├──────┬────────┬─────────┬────────┬────────┬─────┤
│ Name │ Leader │ Current │ Online │ Active │ Lag │
├──────┼────────┼─────────┼────────┼────────┼─────┤
│ n1m1 │        │ false   │ true   │ 0.92s  │ 9   │
│ n1m2 │        │ true    │ true   │ 0.92s  │ 0   │
│ n1m3 │        │ true    │ true   │ 0.92s  │ 0   │
│ n2m1 │        │ true    │ true   │ 0.92s  │ 0   │
│ n2m2 │ yes    │ true    │ true   │ 0.00s  │ 0   │
╰──────┴────────┴─────────┴────────┴────────┴─────╯

```

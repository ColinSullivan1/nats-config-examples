FROM golang:1.19-alpine AS builder

ARG VERSION="localtest"

RUN apk add --update git
RUN mkdir -p src/github.com/nats-io && \
    cd src/github.com/nats-io/ && \
    git clone https://github.com/nats-io/natscli.git && \
    cd natscli/nats && \
    go build -ldflags "-w -X main.version=${VERSION}" -o /nats

RUN mkdir -p src/github.com/nats-io && \
    cd src/github.com/nats-io/ && \
    git clone https://github.com/nats-io/nats-server.git && \
    cd nats-server && \
    go build -ldflags "-w -X main.version=${VERSION}" -o /nats-server

RUN go install github.com/nats-io/nsc@latest

FROM alpine:latest

RUN apk add --update ca-certificates && mkdir -p /nats/bin && mkdir /nats/conf

COPY nats-server.conf /nats/conf/nats-server.conf
COPY --from=builder /nats /bin/nats
COPY --from=builder /nats-server /bin/nats-server
COPY --from=builder /go/bin/nsc /bin/nsc

EXPOSE 4222 8222 6222 5222

ENTRYPOINT ["/bin/nats-server"]
CMD ["-c", "/nats/conf/nats-server.conf"]

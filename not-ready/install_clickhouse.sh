#!/bin/bash
set -x

sudo mkdir -p /opt/clickhouse/{data,etc,log}

sudo docker run -d --name clickhouse_host \
     --ulimit nofile=262144:262144 \
     -p 8123:8123 \
     -v /opt/clickhouse/log:/var/log/clickhouse-server \
     -v /opt/clickhouse/data:/var/lib/clickhouse \
     clickhouse/clickhouse-server:22.8.1
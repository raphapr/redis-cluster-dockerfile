#!/bin/bash
cd /app/redis
redis_port=$1
sed -i "s/^/#/g" redis.conf
echo "port $redis_port" >> redis.conf
echo "maxmemory 600mb" >> redis.conf
echo "maxmemory-policy noeviction" >> redis.conf
echo "cluster-enabled yes" >> redis.conf
echo "cluster-node-timeout 15000" >> redis.conf
echo "cluster-config-file nodes-"$redis_port".conf " >> redis.conf
echo "bind 0.0.0.0" >> redis.conf
redis-server redis.conf
while 1;do
        sleep 30;
done

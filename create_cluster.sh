#!/bin/bash

public_ip=$(curl -s http://whatismijnip.nl |cut -d " " -f 5)

if [ -n $1 ];then
	for i in `seq 1 6`;
	do
		docker run -d --net=host redis_cluster 700$i $1
	done  
fi


redis-cli -p 7001 cluster addslots {0..5500}
redis-cli -p 7002 cluster addslots {5501..11000}
redis-cli -p 7003 cluster addslots {11001..16383}

redis-cli -p 7001 cluster meet $public_ip 7002
redis-cli -p 7001 cluster meet $public_ip 7003
redis-cli -p 7001 cluster meet $public_ip 7004
redis-cli -p 7001 cluster meet $public_ip 7005
redis-cli -p 7001 cluster meet $public_ip 7006

sleep 2

redis-cli -p 7004 CLUSTER REPLICATE $(redis-cli -p 7001 cluster nodes | grep myself | cut -d " " -f1)
sleep 1
redis-cli -p 7005 CLUSTER REPLICATE $(redis-cli -p 7002 cluster nodes | grep myself | cut -d " " -f1)
sleep 1
redis-cli -p 7006 CLUSTER REPLICATE $(redis-cli -p 7003 cluster nodes | grep myself | cut -d " " -f1)

#!/bin/bash

for i in `seq 1 6`;
do
	docker run -d --net=host teste 700$i
done  

redis-cli -p 7001 cluster addslots {0..5500}
redis-cli -p 7002 cluster addslots {5501..11000}
redis-cli -p 7003 cluster addslots {11001..16383}

redis-cli -p 7001 cluster meet 127.0.0.1 7002
redis-cli -p 7001 cluster meet 127.0.0.1 7003
redis-cli -p 7001 cluster meet 127.0.0.1 7004
redis-cli -p 7001 cluster meet 127.0.0.1 7005
redis-cli -p 7001 cluster meet 127.0.0.1 7006

for i in `seq 4 6`;
do
        redis-cli -p 700$i CLUSTER REPLICATE $(redis-cli -p 7001 cluster nodes | grep myself | cut -d " " -f1)
done  

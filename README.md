# redis-cluster-dockerfile
 Dockerfile to run a Redis Cluster.
 
 CentOS 6.6, Redis 3.01
 
 The cluster is 6 redis instances running with 3 master & 3 slaves, one slave for each master. They run on ports 7001 to 7006.

### Installation

1. Install [Docker](https://www.docker.com/).

2. Install the redis-cli. E.g. with following command in Ubuntu: `apt-get install redis-server`

3. Download dockerfile: `https://github.com/raphapr/redis-cluster-dockerfile.git && cd redis-cluster-dockerfile`

4. Build image:: `docker build -t "redis_cluster" .`

### Usage

#### Run `redis-server`
    
    docker run -d --net=host redis_cluster 7000
    
Add how many you want.

#### Create the cluster automatically

    ./create_cluster.sh

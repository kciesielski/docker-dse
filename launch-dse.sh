#!/bin/bash
# Example usage (1 node with Solr): <script_name> <dse_image_name> 1 -s
IMAGE=$1
NUM_NODES=$2
NODE_OPTS=$3
echo Running $NUM_NODES nodes with options $NODE_OPTS
[ -z "$CLUSTER_NAME" ] && CLUSTER_NAME="Test_Cluster"
docker run -d -e CLUSTER_NAME="$CLUSTER_NAME" --name nodee1 -p 7000:7000 -p 9042:9042 -p 9160:9160 -p 8983:8983 -p 8984:8984 -p 4040:4040 -p 7080:7080 -p 7081:7081 -p 7077:7077 -p 8012:8012 -p 50030:50030 -p 50060:50060 -p 9290:9290 -p 10000:10000 -p 61621:61621 $IMAGE $NODE_OPTS
SEEDS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' nodee1)
let n=1
while [ $n != $NUM_NODES ]; do
echo Launching additional node $n...
let n=n+1
docker run -d -e SEEDS=$SEEDS -e CLUSTER_NAME="$CLUSTER_NAME" --name nodee${n} $IMAGE
$NODE_OPTS
done

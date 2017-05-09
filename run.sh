#!/bin/bash

printf "\nThis script is valid to: \n $(date -r run.sh) \n"
echo -------------------
echo "Starting with Zookeeper"

SCALA_VERSION=2.12
KAFKA_VERSION=0.10.2.0

# declare -a keepers=(zk1 zk2 zk3)
declare -a keepers=(zoo1 zoo2 zoo3)
KAFKA_DOCKER=kafkeeper
docker rm -f kfka
FROM_PORT=2181

for i in "${keepers[@]}"
do
  # echo "$i"
  docker rm -f "$i"
  docker run --name "$i" --restart always -d -p "$FROM_PORT":2181 zookeeper:3.4.10
  docker exec -it "$i" sh -c "cd bin ; ./zkServer.sh start"
  FROM_PORT="$((FROM_PORT+1))"
done

#build zookeeper cluster
#docker-compose up -d

#docker run --name zk1 --restart always -d zookeeper:3.4.10

docker build -t "$KAFKA_DOCKER" .
docker run -dit --name kfka --link zoo1:zk1 --link zoo2:zk2 --link zoo3:zk3 -p 9092:9092 "$KAFKA_DOCKER" sh
docker exec -it kfka sh -c "cd opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION" ;  ./bin/kafka-server-start.sh config/server.properties"


#---------------------------------------------
# docker exec -it kfka sh
# cd opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
# sh bin/kafka-server-start.sh config/server.properties

## Let's start ...
1) Make sure you got Docker installed.
2) just ... ```./run``` it!

## Kafka commands

* Create topic

```
bin/kafka-topics.sh --create --zookeeper localhost:2181,localhost:2182,localhost:2183 --replication-factor 1 --partitions 1 --topic logstash
```

* List topics
from localhost

```
bin/kafka-topics.sh --list --zookeeper localhost:2181,localhost:2182,localhost:2183
```

from another connected machine/docker
```
bin/kafka-topics.sh --list --zookeeper zoo1:2181,zoo2:2181,zoo3:2181
```

* Delete topic

```
bin/kafka-topics.sh --delete --zookeeper ZOOKEEPER1:2181,ZOOKEEPER2:2181,ZOOKEEPER3:2181 \
    --topic my-replicated-topic
```

* Producer

```
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic logstash
```

* Consumer

```
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic logstash --from-beginning
```
bin/kafka-console-consumer.sh --bootstrap-server kfka:9092 --topic logstash --from-beginning

bin/kafka-topics.sh --create --zookeeper zoo1:2181,zoo2:2182,zoo3:2183 --replication-factor 1 --partitions 1 --topic test

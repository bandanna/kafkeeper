FROM alpine:3.5

ENV LANG C.UTF-8


#Start by installing OpenJdk 8 jre version on Alpine
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u121
ENV JAVA_ALPINE_VERSION 8.121.13-r0

RUN apk add --no-cache openjdk8-jre


# Add Scala and Kafka
ARG SCALA_VERSION=2.12
ARG KAFKA_VERSION=0.10.2.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"


RUN apk add --update tar wget\
    && wget -q http://apache.mirrors.spacedump.net/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz \
    && mkdir opt && tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt \
    && rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

EXPOSE 9092 2181

#Running Kafka
RUN apk add bash

COPY kafka_2.12-0.10.2.0/config/server.properties /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/config
# COPY kafka_2.12-0.10.2.0/bin/kafka-server-start.sh /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin
# COPY kafka_2.12-0.10.2.0/bin/kafka-topics.sh /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/bin

#RUN cd opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
#RUN sh bin/kafka-server-start.sh config/server.properties

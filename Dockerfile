# get alpine image for jdk
FROM openjdk:8-alpine

# define java/scala version and home location
ENV JAVA_VERSION=1.8.0
ENV SCALA_VERSION=2.12.4 \
    SCALA_HOME=/usr/share/scala \
    SBT_VERSION=0.13.16 \
    SBT_HOME=/usr/local/sbt


# Update image with dependencies
RUN apk --update \
    add tar \
        bash \
        wget \
        ca-certificates \
        bash



# download and install scala
RUN wget -qO /tmp/scala-${SCALA_VERSION}.tgz http://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz \
    && tar -xzf /tmp/scala-${SCALA_VERSION}.tgz \
    && mkdir -p ${SCALA_HOME} \
    && mv scala-${SCALA_VERSION}/bin scala-${SCALA_VERSION}/lib ${SCALA_HOME} \
    && ln -s ${SCALA_HOME}/bin/* /usr/bin/ \
    && rm -rf /tmp/*


# download and install sbt
RUN wget -qO /tmp/sbt-${SBT_VERSION}.tgz https://cocl.us/sbt-0.13.16.tgz \
    && tar -xzf /tmp/sbt-${SBT_VERSION}.tgz \
    && mkdir -p ${SBT_HOME} \
    && mv sbt/* ${SBT_HOME} \
    && ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt \
    && chmod 0755 /usr/local/bin/sbt \
    && sbt sbtVersion


# download spark and uncompress it
RUN wget http://apache.mirror.anlx.net/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz \
    && tar -xzf spark-2.4.0-bin-hadoop2.7.tgz \
    && mv spark-2.4.0-bin-hadoop2.7 /spark \
    && rm spark-2.4.0-bin-hadoop2.7.tgz

# copy master startup script to the image
COPY start-master.sh /start-master.sh

# copy worker startup script to the image
COPY start-worker.sh /start-worker.sh

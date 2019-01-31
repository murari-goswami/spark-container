#!/usr/bin/env bash

# create network
##docker network create spark_network

# register master to the network and start the master container
docker run --rm -it --name spark-master --hostname spark-master \
    -p 7077:7077 -p 8081:8081 --network spark_network spark-container:latest /bin/sh

# register worker to the network and start the worker container
docker run --rm -it --name spark-worker --hostname spark-worker \
    --network spark_network spark-container:latest /bin/sh \

# run the master
/spark/bin/spark-class org.apache.spark.deploy.master.Master --ip spark-master --port 7077 --webui-port 8081

# run the worker
/spark/bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port 8081 spark://spark-master:7077

# run the driver
docker run --rm -it --network spark_network spark-container:latest

# submit an application to the cluster
/spark/bin/spark-submit --master spark://spark-master:7077 --class \
    org.apache.spark.examples.SparkPi \
    /spark/examples/jars/spark-examples_2.11-2.4.0.jar 1000


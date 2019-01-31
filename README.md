# Spark-Container

## Outline
The repo can spin spark distributed network for multiple nodes as docker containers. It can mount test data and load
spark algorithms/ ML models and execute different tests. The default is a single node cluster with 1 master. 
However, in order to fully utilize the power of multiple worker nodes, scale feature of docker-compose can be 
utilized to ramp up cluster with multiple nodes.

## Container components
source from alpine openjdk image
dependencies - tar, bash, wget, ca-certificates, bash, scala, sbt, spark   
     
## Container Orchestration
Use following commands to ramp up the cluster with dynamic number of worker nodes.

`docker-compose up --scale spark-worker=3`

The workers are registered with master through bridge network. The network details are mentioned in the docker-compose
file and internally utilized as part of docker-compose up invocation.

## Web UI
The Web UI is accessible at http://localhost:8080 with default port maintained as 8080. In case you need to change the 
default port, please update that in the docker-compose file. The Web UI is maintained there for registering the master
and the workers.

## Inject Algorithm/ model for testing

## Mount data for testing

## Execute tests   

#!/usr/bin/env bash
NO_OF_WORKER_NODES=${1}
docker-compose up --scale spark-worker=${NO_OF_WORKER_NODES}
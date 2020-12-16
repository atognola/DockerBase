#!/bin/bash

IMAGE_NAME="falcon/mowi15_179:1.0"
CONTAINER_NAME="falcon_sdk"
CAMELROOT="/data/tttech/git/cmdb-razor/"

sudo docker start $CONTAINER_NAME
sudo docker exec -it $CONTAINER_NAME /bin/bash

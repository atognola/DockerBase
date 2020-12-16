#!/bin/bash

IMAGE_NAME="falcon/mowi15_179:1.0"
REGISTRY_URL="localhost:5000"
USER="username"
PASS="pass"

sudo docker login $REGISTRY_URL -u $USER -p $PASS

sudo docker tag $IMAGE_NAME $REGISTRY_URL/$IMAGE_NAME
sudo docker image push $REGISTRY_URL/$IMAGE_NAME

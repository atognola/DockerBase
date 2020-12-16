#!/bin/bash

IMAGE_NAME="falcon/mowi15_179:1.0"
REGISTRY_URL="localhost:5000"
CONTAINER_NAME="falcon_sdk"
CAMELROOT="/data/tttech/git/cmdb-razor/"

USER="username"
PASS="pass"

sudo docker login $REGISTRY_URL -u $USER -p $PASS

sudo docker run -it --name $CONTAINER_NAME --network=host \
-v $(pwd)/data:/data:Z \
-v $HOME/.ssh:/home/user/.ssh:Z \
-v $HOME/.gitconfig:/home/user/.gitconfig:Z \
-e LOCAL_USER_ID=`id -u $USER` \
-e CAMELROOT=$CAMELROOT \
$REGISTRY_URL/$IMAGE_NAME /bin/bash

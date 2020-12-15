#!/bin/bash

sudo docker run -it --name falcon --network=host \
-v $(pwd)/data:/data:Z \
-v $HOME/.ssh:/home/user/.ssh:Z \
-v $HOME/.gitconfig:/home/user/.gitconfig:Z \
-e LOCAL_USER_ID=`id -u $USER` \
-e CAMELROOT="/data/tttech/git/cmdb-razor/" \
localhost:5000/falcon /bin/bash

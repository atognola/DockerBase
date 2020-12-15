#!/bin/bash

sudo docker tag falcon/mowi15:1.0 localhost:5000/falcon/mowi15_179:latest
sudo docker image push localhost:5000/falcon/mowi15_179:latest

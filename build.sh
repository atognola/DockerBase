#!/bin/bash

IMAGE_NAME="falcon/mowi15_179:1.0"
REGISTRY_URL="localhost:5000"
USER="username"
PASS="pass"

sudo docker build -t $IMAGE_NAME .

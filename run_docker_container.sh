#!/bin/bash

# Pull image command
# docker build -t tensorflow:0.11 .

# Run one time only
    # --runtime=nvidia \
docker run -it \
    -p 8888:8888 \
    -p 6006:6006 \
    -v /home/bunzz/CapstoneProject/model-training/polyvore:/root \
	tensorflow:0.11
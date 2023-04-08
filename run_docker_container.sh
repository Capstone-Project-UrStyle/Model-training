#!/bin/bash

# --runtime=nvidia \
sudo docker run -it \
    -p 8888:8888 \
    -p 6006:6006 \
    -v /home/bunzz/CapstoneProject/model-training/polyvore:/root \
	tensorflow:0.11
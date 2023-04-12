#!/bin/bash

# Pull image command
# docker build -t python:2.7.12 .

# Run one time only
docker run -it \
    -p 8888:8888 \
    -p 6006:6006 \
    -v /home/bunzz/CapstoneProject/model-training/polyvore:/root \
	python:2.7.12
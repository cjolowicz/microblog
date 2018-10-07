#!/bin/bash

docker run --name microblog \
       --detach \
       --publish 8000:5000 \
       --rm \
       microblog:latest

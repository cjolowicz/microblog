#!/bin/bash

SECRET_KEY=33b7497205884cd2801a03ac16109409

docker run --name microblog \
       --detach \
       --publish 8000:5000 \
       --rm \
       --env SECRET_KEY=$SECRET_KEY \
       microblog:latest

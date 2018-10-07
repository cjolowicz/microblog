#!/bin/bash

MYSQL_DATABASE=microblog
MYSQL_USER=microblog
MYSQL_PASSWORD=a737e6b789a04be6a15c73d43a83b967
MYSQL_RANDOM_ROOT_PASSWORD=yes

SECRET_KEY=33b7497205884cd2801a03ac16109409
DATABASE_URL=mysql+pymysql://$MYSQL_USER:$MYSQL_PASSWORD@mysql/$MYSQL_DATABASE

# Start mysql container.
docker run --name mysql \
       --detach \
       --env MYSQL_RANDOM_ROOT_PASSWORD=$MYSQL_RANDOM_ROOT_PASSWORD \
       --env MYSQL_DATABASE=$MYSQL_DATABASE \
       --env MYSQL_USER=$MYSQL_USER \
       --env MYSQL_PASSWORD=$MYSQL_PASSWORD \
       mysql/mysql-server:5.7

# Start microblog container.
docker run --name microblog \
       --detach \
       --publish 8000:5000 \
       --rm \
       --env SECRET_KEY=$SECRET_KEY \
       --link mysql:mysql \
       --env DATABASE_URL=$DATABASE_URL \
       microblog:latest

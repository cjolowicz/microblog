#!/bin/bash

MYSQL_VOLUME=microblog-mysql-volume
MYSQL_DATABASE=microblog
MYSQL_USER=microblog
MYSQL_PASSWORD=a737e6b789a04be6a15c73d43a83b967
MYSQL_RANDOM_ROOT_PASSWORD=yes

SECRET_KEY=33b7497205884cd2801a03ac16109409
DATABASE_URL=mysql+pymysql://$MYSQL_USER:$MYSQL_PASSWORD@mysql/$MYSQL_DATABASE
ELASTICSEARCH_URL=http://elasticsearch:9200


# Start mysql container.
docker volume ls -q | fgrep -q $MYSQL_VOLUME ||
    docker volume create --name $MYSQL_VOLUME
docker run --name mysql \
       --detach \
       --env MYSQL_RANDOM_ROOT_PASSWORD=$MYSQL_RANDOM_ROOT_PASSWORD \
       --env MYSQL_DATABASE=$MYSQL_DATABASE \
       --env MYSQL_USER=$MYSQL_USER \
       --env MYSQL_PASSWORD=$MYSQL_PASSWORD \
       --volume $MYSQL_VOLUME:/var/lib/mysql \
       mysql/mysql-server:5.7

# Start elasticsearch container.
docker run --name elasticsearch \
       --detach \
       --publish 9200:9200 \
       --publish 9300:9300 \
       --rm \
       --env discovery.type=single-node \
       docker.elastic.co/elasticsearch/elasticsearch-oss:6.1.1

# Start microblog container.
docker run --name microblog \
       --detach \
       --publish 8000:5000 \
       --rm \
       --env SECRET_KEY=$SECRET_KEY \
       --link mysql:mysql \
       --env DATABASE_URL=$DATABASE_URL \
       --link elasticsearch:elasticsearch \
       --env ELASTICSEARCH_URL=$ELASTICSEARCH_URL \
       microblog:latest

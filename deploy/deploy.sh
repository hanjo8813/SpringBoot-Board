#!/bin/bash

DOCKER_USERNAME=$1
DOCKER_REPOSITORY=$2

#cd /srv/

docker run -d --name spring_con -p 8080:8080 -e "SPRING_PROFILES_ACTIVE=prod" $DOCKER_USERNAME/$DOCKER_REPOSITORY:spring_img
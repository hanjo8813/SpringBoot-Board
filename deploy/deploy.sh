###!/bin/bash

EXIST_BLUE=$(docker ps | grep blue)

## 만약 blue(8081)가 구동중이 아니라면? : blue(8081)를 실행 -> green(8082)은 종료
if [ -z "$EXIST_BLUE" ]; then
    echo "RUN BLUE"
    docker-compose -p board-blue -f docker-compose.blue.yml up -d

    sleep 60

    echo "DOWN GREEN"
    docker-compose -p board-green -f docker-compose.green.yml down
else
    echo "RUN GREEN"
    docker-compose -p board-green -f docker-compose.green.yml up -d

    sleep 60

    echo "DOWN BLUE"
    docker-compose -p board-blue -f docker-compose.blue.yml down
fi


# 도커만 사용했을 때
#IS_BLUE_OPEN=$(docker ps | grep spring_con_blue)
#
## 만약 blue(8081)가 구동중이 아니라면? : blue(8081)를 실행 -> green(8082)은 종료
#if [ -z "$IS_BLUE_OPEN"];then
#  echo "Run blue(8081)"
#  docker run -d --name spring_con_blue -p 8081:8080 -e "SPRING_PROFILES_ACTIVE=prod" $DOCKER_USERNAME/$DOCKER_REPOSITORY:spring_img
#
#  sleep 60
#
#  echo "Kill green(8082)"
#  docker stop spring_con_green
#  docker rm spring_con_green
#else
#  echo "Run green(8082)"
#  docker run -d --name spring_con_green -p 8082:8080 -e "SPRING_PROFILES_ACTIVE=prod" $DOCKER_USERNAME/$DOCKER_REPOSITORY:spring_img
#
#  sleep 60
#
#  echo "Kill blue(8081)"
#  docker stop spring_con_blue
#  docker rm spring_con_blue
#fi

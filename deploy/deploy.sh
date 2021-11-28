###!/bin/bash

# GitHub에 등록한 환경변수 받아오기
DOCKER_USERNAME=$1
DOCKER_REPOSITORY=$2
DOCKER_TAG=$3
DB_URL=$4
DB_USERNAME=$5
DB_PASSWORD=$6

# 환경변수로 docker-compose 전체용 .env 파일 생성
echo -e "DOCKER_USERNAME=$DOCKER_USERNAME\nDOCKER_REPOSITORY=$DOCKER_REPOSITORY\nDOCKER_TAG=$DOCKER_TAG" > .env

# docker-compose spring 컨테이너용 DB.env 파일 생성
echo -e "DB_URL=$DB_URL\nDB_USERNAME=$DB_USERNAME\nDB_PASSWORD=$DB_PASSWORD" > DB.env

# 기존 이미지는 삭제 + 빌드된 최신 이미지 pull
docker rmi $DOCKER_USERNAME/$DOCKER_REPOSITORY:$DOCKER_TAG
docker pull $DOCKER_USERNAME/$DOCKER_REPOSITORY:$DOCKER_TAG
sleep 20

## 만약 blue(8081)가 구동중이 아니라면? : blue(8081)를 실행 -> green(8082)은 종료
EXIST_BLUE=$(docker ps | grep blue)

if [ -z "$EXIST_BLUE" ]; then
    echo "@@@@@@@@@@@@@@@@@@@@@@ RUN BLUE @@@@@@@@@@@@@@@@@@@@@@"
    docker-compose -p compose_blue -f docker-compose.blue.yml up -d

    sleep 60

    echo "@@@@@@@@@@@@@@@@@@@@@@ DOWN GREEN @@@@@@@@@@@@@@@@@@@@@@"
    docker-compose -p compose_green -f docker-compose.green.yml down
else
    echo "@@@@@@@@@@@@@@@@@@@@@@ RUN GREEN @@@@@@@@@@@@@@@@@@@@@@"
    docker-compose -p compose_green -f docker-compose.green.yml up -d

    sleep 60

    echo "@@@@@@@@@@@@@@@@@@@@@@ DOWN BLUE @@@@@@@@@@@@@@@@@@@@@@"
    docker-compose -p compose_blue -f docker-compose.blue.yml down
fi

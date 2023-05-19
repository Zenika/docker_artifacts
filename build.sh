#!/usr/bin/env bash

cd $1
if [ $# -gt 2 ]; then
    DOCKER_BUILDKIT=1 docker build --force-rm --compress -t $1 --build-arg $3 --build-arg $4 --build-arg $5 --build-arg $6 --build-arg $7 .
else
    DOCKER_BUILDKIT=1 docker build --force-rm --compress -t $1 .
fi

#docker tag $1 nexus:9820/$1:$2
#docker tag $1 nexus:9820/$1:latest
#docker rmi $1

cd ..
echo
echo "Available images:"
echo "================="
docker images
echo
echo "Existing containers:"
echo "===================="
docker ps -a

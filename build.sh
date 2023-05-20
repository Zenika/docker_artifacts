#!/usr/bin/env bash

cd $1

if [ $# -gt 2 ]; then
    DOCKER_BUILDKIT=1 docker build --force-rm --compress -t $1 --build-arg $3 --build-arg $4 --build-arg $5 --build-arg $6 --build-arg $7 .
    #DOCKER_BUILDKIT=1 dtools build --force-rm --compress -t $1 --build-arg $3 --build-arg $4 --build-arg $5 --build-arg $6 --build-arg $7 .
else
    DOCKER_BUILDKIT=1 docker build --force-rm --compress -t $1 .
    #DOCKER_BUILDKIT=1 dtools build --force-rm --compress -t $1 .
fi

docker tag $1 $1:$2
#docker rmi $1
#dtools rmi $1

cd ..
echo
echo "Available images:"
echo "================="
docker images
#dtools lsi
echo
echo "Existing containers:"
echo "===================="
docker ps -a
#dtools ls

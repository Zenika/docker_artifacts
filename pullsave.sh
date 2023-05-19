#!/bin/bash

docker pull nexus:9820/$1

docker save nexus:9820/$1 -o $2.tar

xz -9evvT8 $2.tar

docker rmi nexus:9820/$1


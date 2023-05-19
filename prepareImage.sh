#!/bin/bash

docker save nexus:9820/$1 -o $2.tar
xz -9evvT8 $2.tar

if [ -f /etc/os-release ]; then
    mv $2.tar.xz /archives/containers/
else
    mv $2.tar.xz /Volumes/archives/containers/
fi


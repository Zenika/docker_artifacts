#!/bin/bash

if [ "$#" -lt 2 ]; then
	echo "You must specify the version number (ex: 1.18.3) and arch (ex: amd64) to download."
	exit 3
fi

export VER=${1}
export ARCH=${2}

echo "Fetching archive..."
sudo wget -q https://go.dev/dl/go${VER}.linux-${ARCH}.tar.gz -O /tmp/go.tar.gz -O /opt/go.tar.gz

echo "Unarchiving..."
cd /opt ; sudo rm -rf go;sudo tar zxf go.tar.gz; sudo rm -f go.tar.gz

echo "Adding LibC compatibility..."
apk add --no-cache gcompat libc6-compat

cd /usr/local && sudo ln -s /opt/go .

echo "Completed."

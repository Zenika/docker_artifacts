#!/usr/bin/env bash


#####
# PLEASE NOTE
# THIS SCRIPT WILL BE USED IN THIS FORM
# UNTIL I'VE COMPLETED THE `build` SUBCOMMAND OF `dtools`
#
# ...STAY TUNED, `dtools build` IS EXPECTED IN BRANCH 0.850 OF `dtools`
####


# USAGE:
# build.sh CONTAINER(directory) TAG buildargs... (no limit)
if [ $# -lt 2 ]; then
    echo "Error: Two mandatory arguments are required."
    echo "Usage: ./build.sh DOCKER_IMAGE_NAME TAG [--build-arg=value ...]"
    exit 1
fi

imgname=$1
imgtag=$2
shift 2
build_args=()

# See if we have --build-args
for arg in "$@"; do
    build_args+=("--build-arg" "$arg")
done

cd $imgname
DOCKER_BUILDKIT=1 docker build --force-rm --compress -t ${imgname}:${imgtag} ${build_args[*]} .
docker tag $imgname:$imgtag $imgname

cd ..
echo
echo "Available images:"
echo "================="
#dtools lsi
docker images
echo
echo "Existing containers:"
echo "===================="
#dtools ls
docker ps -a

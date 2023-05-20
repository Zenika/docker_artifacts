#!/usr/bin/env bash

PACKAGE=$1
PASSWORD=$2

curl -u "jfgratton:${PASSWORD}" -H "Content-Type: multipart/form-data" --data-binary "@./${PACKAGE}.deb" "https://nexus.famillegratton.net:1808/repository/aptLocal/"


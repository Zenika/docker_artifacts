#!/usr/bin/env bash

# $1 : username
# $2 : password
# $3 : .deb package (the package name, with path)
# $4 : Nexus URL
# $5 : Repo path
# $6 : $3 without path


# Push the DEB package to the Nexus repository using curl
#curl -v -u $1:$2 --upload-file "$DEB_PACKAGE_PATH" "$NEXUS_URL/$REPO_PATH/package1.deb"

curl -v -u $1:$2 --upload-file "$3" "$4/$5/$6"

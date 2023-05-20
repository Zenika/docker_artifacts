#!/bin/bash

UPLOADUSER="yumupload"
UPLOADUSERPASSWD="upload"
NEXUSHOSTURL="https://nexus:1808/repository"
NEXUSREPO="dnfLocal"
RPMNAME=`basename $1`

#curl -v --user 'yumupload:upload' --upload-file $1 https://nexus:1808/repository/dnfLocal/$RPMNAME

curl -v --user '$UPLOADUSER:$UPLOADUSERPASSWD' --upload-file $1 $NEXUSHOSTURL/$NEXUSREPO/$RPMNAME
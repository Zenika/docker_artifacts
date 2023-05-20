#!/bin/bash

USER='jfgratton:jiefg000'
DNFREPO='https://nexus.famillegratton.net:1808/repository/dnfLocal/'

# sudo rm -rf /projets;sudo mkdir /projets; sudo chown builder:devops /projets
# git clone $1 /projets

# # If this rpm has never been built, we initialize tito
# if [ ! -d "/projets/.tito"]; then
#     tito init
# fi

# tito tag

# git push --follow-tags origin

# tito build --rpm | tee /tmp/tito.out

# # Upload RPM to repo
FULLPATH=`tail -1 /tmp/tito.out |xargs|awk -F' ' '{print $2}'`
RPMNAME=`tail -1 /tmp/tito.out |xargs|awk -F' ' '{print $2}' | cut -d'/' -f5`
curl -v --user $USER --upload-file $FULLPATH $DNFREPO/$RPMNAME
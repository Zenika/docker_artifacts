# syntax=docker/dockerfile:1
FROM debian:stable-slim
ARG arch=amd64
ARG projectdir=/projets
ARG artefacturl=https://nginx:9443/artifacts
ARG certurl=https://nginx:9443/certificates
ARG certname=rootCAfamillegratton.crt
LABEL maintainer="jean-francois@famillegratton.net"
LABEL build-date="20230615"
LABEL dockerfile-version="Z4.01.00"
LABEL original-binary-version="debian stable"
LABEL dockerized-software="DEB builder"
LABEL container-use="DEB package builder"

ENV TZ="America/Montreal"

COPY files/ssh/* /.ssh/
COPY files/bashrc /home/builder/.bashrc
COPY files/gitconfig /home/builder/.gitconfig
COPY files/install_golang.sh /opt/bin/
COPY files/push2repo.sh /home/builder/bin/

RUN mkdir -p ${projectdir} && apt-get update && apt-get dist-upgrade -y && apt-get dselect-upgrade -y && apt-get upgrade -y && \
apt-get install -y vim-tiny git gcc g++ build-essential fakeroot devscripts wget sudo openssh-client && \
groupadd -g 2500 devops && useradd -u 2551 -g 2500 -c 'DEB Builder' -d /home/builder -m -s /bin/bash builder && apt-get autoremove -y && apt-get clean && \
echo "%devops ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devops && mv /.ssh /home/builder/ && \
chown -R builder:devops /home/builder ${projectdir} && \
wget -q --no-check-certificate ${artefacturl}/dumb-init_1.2.5_$arch -O /usr/bin/dumb-init && \
wget -q --no-check-certificate ${certurl}/${certname} -O /usr/local/share/ca-certificates/${certname} && \
chmod 755 /usr/bin/dumb-init /opt/bin/* /home/builder/bin/* && \
update-ca-certificates --fresh && \
cd /home/builder/.ssh && chmod 600 id_rsa && chmod 644 id_rsa.pub config && \
echo "FINAL package upgrade ..." && apt-get update && apt-get upgrade -y && dpkg -P -a && apt-get auto-remove -y && apt-get clean -y && \
echo "4.01.00" > /.DOCKERVERSION && echo "OS: Debian stable" >> /.DOCKERVERSION

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

VOLUME ["${projectdir}"]
CMD [ "/usr/bin/tail", "-f", "/.DOCKERVERSION" ]

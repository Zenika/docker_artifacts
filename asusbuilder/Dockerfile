# syntax=docker/dockerfile:1
FROM ubuntu:latest
ARG arch=amd64
ARG certificateurl=https://nginx:9443/certificates
ARG certname=rootCAfamillegratton.crt
ARG artifactsurl=https://nginx:9443/artifacts
ARG projectdir=/projets
LABEL maintainer="jean-francois@famillegratton.net"
LABEL build-date="20230605"
LABEL dockerfile-version="1.01.00"
LABEL original-binary-version="ubuntu latest"
LABEL dockerized-software="Asustor builder"
LABEL container-use="APKG package builder"

ENV TZ="America/Montreal"

COPY files/ssh/* /.ssh/
COPY files/bashrc /home/builder/.bashrc
COPY files/gitconfig /home/builder/.gitconfig
COPY files/buildtools/* /opt/bin/
#COPY files/push2repo.sh /

RUN mkdir -p /projets && groupadd -g 2500 devops && useradd -u 2551 -g 2500 -c 'APKG Builder' -d /home/builder -m -s /bin/bash builder && \
apt-get update && apt-get dist-upgrade -y && apt-get dselect-upgrade -y && apt-get upgrade -y && \
apt-get install -y vim-tiny git wget sudo openssh-client gnupg1 && \
echo "%devops ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devops && mv /.ssh /home/builder/ && \
chown -R builder:devops /home/builder /projets
RUN wget -q --no-check-certificate ${artifactsurl}/dumb-init_1.2.5_${arch} -O /usr/bin/dumb-init && \
wget -q --no-check-certificate ${certificateurl}/${certname} -O /usr/local/share/ca-certificates/rootCAfamillegratton.crt && \
wget -q --no-check-certificate ${artifactsurl}/asustor-toolchain.tar.xz -O /asustor-toolchain.tar.xz && \
wget -q --no-check-certificate ${artifactsurl}/famillegratton.list -O /etc/apt/sources.list.d/famillegratton.list && \
wget -q --no-check-certificate ${artifactsurl}/nexus-public.gpg.key -O /root/nexus-public.gpg.key && \
apt-key add /root/nexus-public.gpg.key && rm /root/nexus-public.gpg.key && \
apt-get update && apt install -y python2 && \
chmod 755 /usr/bin/dumb-init /opt/bin/* && \
update-ca-certificates --fresh && \
cd /home/builder/.ssh && chmod 600 authorized_keys id_rsa && chmod 644 id_rsa.pub config && \
echo "FINAL package upgrade ..." && apt-get update && apt-get upgrade -y && dpkg -P -a && apt-get auto-remove -y && apt-get clean -y && \
echo "1.01.00" > /.DOCKERVERSION

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]

VOLUME ["/projets"]
CMD [ "/usr/bin/tail", "-f", "/.DOCKERVERSION" ]

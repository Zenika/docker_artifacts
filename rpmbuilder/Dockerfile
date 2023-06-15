#FROM fedora:36
FROM rockylinux/rockylinux:9-minimal
ARG arch=amd64
ARG certurl=https://nginx:9443/certificates
ARG certname=rootCAfamillegratton.crt
ARG artifacturl=https://nginx:9443/artifacts
ARG projectdir=/projets
LABEL maintainer="jean-francois@famillegratton.net"
LABEL build-date="20230615"
LABEL dockerfile-version="Z11.01.00"
LABEL original-binary-version="0.6.21"
LABEL dockerized-software="tito"
LABEL container-use="RPM package builder"

USER root
ENV TZ="America/Montreal"

COPY files/ssh/* /.ssh/
COPY files/gitconfig /
COPY files/buildtools/* /opt/bin/
COPY files/bashrc /home/builder/.bashrc
COPY files/push2repo.sh /home/builder/bin/

RUN mkdir -p ${projectdir} /tmp/tito && \
microdnf update -y && microdnf install -y wget vim python3-pip which dnf openssh-clients rpmdevtools git tar bzip2 bind-utils sudo ca-certificates && \
pip3 install --upgrade pip && pip3 install tito

RUN groupadd -g 2500 devops && useradd -u 2551 -g 2500 -c 'RPM Builder' -d /home/builder -m -s /bin/bash builder && \
echo "%devops ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devops && mv /.ssh /home/builder && mv /gitconfig /home/builder/.gitconfig && \
cd /home/builder && chmod 700 .ssh && chmod 600 .ssh/id_rsa && \
chmod 644 .ssh/config .ssh/id_rsa.pub && chown -R builder:devops /home/builder ${projectdir} /tmp/tito && \
wget -q --no-check-certificate ${artifacturl}/dumb-init_1.2.5_$arch -O //usr/bin/dumb-init && \
wget -q --no-check-certificate ${certurl}/${certname} -O /etc/pki/ca-trust/source/anchors/${certname} && \
update-ca-trust && chmod 755 /usr/bin/dumb-init && \
rm -f /etc/localtime && ln -s -f /usr/share/zoneinfo/America/Montreal /etc/localtime && \
chmod 755 /opt/bin/* /home/builder/bin/* && chown 0:devops /opt/bin/* && microdnf clean all && \
echo "Look into /opt/bin for helper scripts to install some languages" > /etc/motd && \
sed -i -e 's/enabled=0/enabled=1/g' /etc/yum.repos.d/rocky-devel.repo && \
echo "tito: 0.6.21" >> /.DOCKERVERSION && echo "DOCKERFILE: 11.00.01" >> /.DOCKERVERSION && \
echo "OS: rockylinux9 minimal" >> /.DOCKERVERSION && echo "Arch: ${arch}" >> /.DOCKERVERSION


ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
VOLUME ["${projectdir}"]
CMD ["/usr/bin/tail", "-f", "/.DOCKERVERSION" ]

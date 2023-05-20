FROM alpine:latest
ARG arch=amd64
ARG certificateurl=https://nginx:9443/certificates
ARG certname=rootCAfamillegratton.crt
ARG artifactsurl=https://nginx:9443/artifacts
ARG projectdir=/projets
LABEL maintainer="jean-francois@famillegratton.net"
LABEL build-date="20230519"
LABEL dockerfile-version="Z4.00.00"
LABEL original-binary-version="n/a"
LABEL dockerized-software="n/a"
LABEL container-use="Alpine APK package builder"

ENV TZ="America/Montreal"

COPY files/ssh/* /.ssh/
COPY files/gitconfig /
COPY files/bashrc /home/builder/.bashrc
COPY files/install_golang.sh /opt/bin/
COPY files/abuild.conf /etc/abuild.conf
COPY files/README.md /

RUN mkdir -p /opt/bin /home/builder/bin ${projectdir} /data && \
apk update --no-cache && \
apk add --no-cache nginx abuild-doc libc6-compat pax-utils openssh-client bash tzdata git alpine-sdk mandoc man-pages sudo busybox-extras vim ca-certificates && \
apk upgrade --no-cache && \
cp /usr/share/zoneinfo/America/Montreal /etc/localtime && \
wget -q --no-check-certificate ${artifactsurl}/dumb-init_1.2.5_${arch}alpine -O /usr/bin/dumb-init && chmod 755 /usr/bin/dumb-init && \
wget -q --no-check-certificate ${certificateurl}/${certname} -O /usr/local/share/ca-certificates/${certname} && \
update-ca-certificates && \
addgroup builder && addgroup devops && \
adduser -D -G builder -g 'Alpine APK package builder' -h /home/builder -s /bin/bash builder && \
addgroup builder devops && addgroup builder abuild && \
echo "%devops ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devops && \
passwd -u builder && \
mv /.ssh /home/builder && mv /gitconfig /home/builder/.gitconfig  && \
chmod 700 /home/builder/.ssh && \
chmod 600 /home/builder/.ssh/id_rsa && \
chown -R builder:devops /home/builder ${projectdir} /data && chmod 775 ${projectdir} /data && cd ${projectdir} && chmod -R 755 /opt/bin && \
echo && echo "Cloning aports..." && \
su -c "abuild-keygen -ain && git clone --depth 1 https://gitlab.alpinelinux.org/alpine/aports" builder && \
mkdir -p /var/cache/distfiles && chgrp abuild /var/cache/distfiles && chmod g+w /var/cache/distfiles && \
mv /README.md ${projectdir} && chown builder:devops ${projectdir}/README.md && echo "Dockerfile: Z4.00.00" > /.DOCKERVERSION && echo "OS: Alpine 3.18" >> /.DOCKERVERSION

COPY files/nginx-default.conf /etc/nginx/http.d/default.conf

RUN chown 0:abuild /etc/abuild.conf && chmod 774 /etc/abuild.conf && apk update && \
sed -i -e 's| "$dir"/opt/*|PATATE|' /usr/bin/abuild && \
sed -i -e 's/PATATE\*/ /' /usr/bin/abuild

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
VOLUME [ "/data", "${projectdir}" ]
CMD [ "/usr/sbin/nginx", "-g", "daemon off;" ]

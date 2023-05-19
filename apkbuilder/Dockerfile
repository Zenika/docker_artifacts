FROM alpine:latest
ARG arch=amd64
ARG certificateurl=https://nginx:9443/certificates/rootCAfamillegratton.crt
ARG artifactsurl=https://nginx:9443/artifacts
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
COPY files/README.md /README.md
COPY files/install_golang.sh /opt/bin/
COPY files/abuild.conf /etc/abuild.conf

RUN mkdir -p /opt/bin /home/builder/bin /projets /data && \
apk update --no-cache && \
apk add --no-cache nginx abuild-doc libc6-compat pax-utils openssh-client bash tzdata git alpine-sdk mandoc man-pages sudo busybox-extras vim ca-certificates && \
apk upgrade --no-cache && \
cp /usr/share/zoneinfo/America/Montreal /etc/localtime && \
wget -q --no-check-certificate ${artifactsurl}/dumb-init_1.2.5_${arch}alpine -O /usr/bin/dumb-init && chmod 755 /usr/bin/dumb-init && \
wget -q --no-check-certificate ${certificateurl} -O /usr/local/share/ca-certificates/rootCAfamillegratton.crt && \
update-ca-certificates && \
addgroup builder && addgroup devops && \
adduser -D -G builder -g 'Alpine APK package builder' -h /home/builder -s /bin/bash builder && \
addgroup builder devops && addgroup builder abuild && \
echo "%devops ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devops && \
passwd -u builder && \
mv /.ssh /home/builder && mv /gitconfig /home/builder/.gitconfig  && \
chmod 700 /home/builder/.ssh && \
chmod 600 /home/builder/.ssh/authorized_keys /home/builder/.ssh/id_rsa && \
chown -R builder:devops /home/builder /projets /data && chmod 775 /projets /data && cd /projets && chmod -R 755 /opt/bin && \
echo && echo "Cloning aports..." && \
su -c "abuild-keygen -ain && git clone --depth 1 https://gitlab.alpinelinux.org/alpine/aports" builder && \
mkdir -p /var/cache/distfiles && chgrp abuild /var/cache/distfiles && chmod g+w /var/cache/distfiles && \
mv /README.md /projets && chown builder:devops /projets/README.md && echo "Alpine 3.17" > /.DOCKERVERSION

COPY files/nginx-default.conf /etc/nginx/http.d/default.conf

RUN chown 0:abuild /etc/abuild.conf && chmod 774 /etc/abuild.conf && apk update && \
sed -i -e 's| "$dir"/opt/*|PATATE|' /usr/bin/abuild && \
sed -i -e 's/PATATE\*/ /' /usr/bin/abuild

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
VOLUME [ "/data", "/projets" ]
CMD [ "/usr/sbin/nginx", "-g", "daemon off;" ]

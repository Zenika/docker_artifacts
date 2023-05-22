FROM alpine:latest
ARG arch=amd64
ARG pguser=PGUSER
ARG pgpasswd=PGPASSWD
ARG pgport=5432
LABEL maintainer="jean-francois@famillegratton.net"
LABEL build-date="20230522"
LABEL dockerfile-version="Z2.00.00"
LABEL original-binary-version="15.x"
LABEL dockerized-software="PostgreSQL"
LABEL container-use="PostgreSQL database"

ENV TZ="America/Montreal"

COPY files/postgres/*.sh /var/lib/postgresql/

RUN mkdir -p /usr/local/share/ca-certificates /run/postgresql && \
apk update --no-cache && \
apk add --no-cache postgresql15 openssh-client sudo bash tzdata ca-certificates && apk upgrade --no-cache && \
cp /usr/share/zoneinfo/America/Montreal /etc/localtime && \
cat /usr/local/share/ca-certificates/rootCAfamillegratton.crt >> /etc/ssl/certs/ca-certificates.crt && \
echo "%postgres ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/postgres && \
cd /var/lib/postgresql/ && chown -R postgres:postgres /run/postgresql . && chmod -R 755 *.sh && \
sed -i -e 's|___USERNAME___|'"${pguser}"'|' createDB.sh && \
sed -i -e 's|___PASSWORD___|'"${pgpasswd}"'|' createDB.sh && \
./initDB.sh && \
echo "host all all all scram-sha-256" >> /var/lib/postgresql/data/pg_hba.conf && \
echo "Dockerfile:Z2.00.00" > /.DOCKERFILE && echo "OS: Alpine 3.18.x" >> /.DOCKERFILE && \
echo "PGSQL: 15.2.x" >> /.DOCKERFILE

COPY --chown=postgres:postgres files/postgres/*.conf /var/lib/postgresql/data/


VOLUME [ "/var/lib/postgresql/data" ]
EXPOSE ${pgport}

USER postgres
RUN sed -i -e 's|___PORT___|'"${pgport}"'|' /var/lib/postgresql/data/postgresql.conf
ENTRYPOINT [ "/bin/sh", "-c", "/usr/bin/postgres -D /var/lib/postgresql/data" ]

<H1>docker_artifacts</H1>

<H2>A quick note...</H2>
Currently the only available code is for {apk,asus,deb,rpm}builder containers, and postgresql.<br>
The reason is quite simple: I need to "anonymize" those containers, that is, strip off everything that is custom from my own (home) setup.<br><br><br>

Docker artifacts to create our own (custom) docker images in order to build your own Home CI-CD pipeline

You will find here the containers to:
- build RedHat-based RPMs
- build Debian-based DEBs
- build AlpineLinux APK
- build Asustor Lockerstor NASes APKG
- build root CA and "plain ssl" server certificates
- host your artefacts, certificates, binaries on a nginx web server with forward/reverse proxy capabilities
- host your binary artefacts (RPM, DEB, Docker Registry) in a Nexus Repository Manager container
- host your repos in a gitea server
- run your own DHCPd with dhcp reservation
- run an haproxy
- run your own DNS
- basic small-size docker images for AlpineLinux, Debian, RockyLinux and VMWare's PhotonOS
- run an AlpineLinux-based PostgreSQL15 server

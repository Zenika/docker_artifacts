<H1>APKBUILDER</H1>You can find more info on how to build APKs at:
<br>

This container is used to create APK packages for AlpineLinux.

<H2>To configure</H2>
<H3>Files in this directory</H3>
- Replace id_rsa and id_rsa.pub (in files/ssh) with valid keys; those are neeed to git clone repos; the config file is optional<br><br>
- Same with files/bashrc, files/gitconfig and files/abuild.conf (especially the MAINTAINER and PACKAGER variables)
<br><br>
A simple nginx daemon runs on the server in order to server tarballs when your source package does not come from a github-like repo, vanilla config is provided in files/nginx-default.conf
<br><br>
<H3>Webserver-based artefacts</H3>
As you see in the Dockerfile, you will need to fetch some files from a webserver. This is especially true for dumb-init (a container-based init replacement), and a root CA certificate (which might or might not be needed).
<br><br>
I've provided vars (the ARGS statements on the top) in a way to provide the correct URL.
<br><br>
* At this time of writing, I do not have an outside URL for dumb-init; this will get fixed SOON *
<br><br>

<H2>To build</H2>
Go to the parent directory, above this one, and run:
```
./build.sh $DIRECTORY_NAME TAG(version) [build-args]
```
Refer to the script to get an idea...
<br><br>



<H2>Further APK packaging help</H2>
<br><br>
The file `PACKAGING.md`, in this directory offers some help on how to use this container.

Further generic help on APK packaging can be found at:

https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package <br>
https://itsufficient.me/blog/alpine-build <br>
https://www.matthewparris.org/build-an-alpine-package/ <br>
https://www.fedux.org/articles/build-alpine-packages-in-a-container.html <br>

<br><br>


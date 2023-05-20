<H1>RPMBUILDER</H1>

This container is used to create RPM packages for RedHat-derived distros.

<H2>To configure</H2>
<H3>Files in this directory</H3>
- Replace id_rsa and id_rsa.pub (in files/ssh) with valid keys; those are neeed to git clone repos; the config file is optional<br><br>
- Same with files/bashrc, files/gitconfig
<br><br>

<H3>Webserver-based artefacts</H3>
As you see in the Dockerfile, you will need to fetch some files from a webserver. This is especially true for dumb-init (a container-based init replacement), and a root CA certificate (which might or might not be needed).
<br><br>
I've provided vars (the ARGS statements on the top) in a way to provide the correct URL.
<br><br>
* At this time of writing, I do not have an outside URL for dumb-init; this will get fixed SOON *
<br><br>

<H2>To build the container</H2>
Go to the parent directory, above this one, and run:
`./build.sh $DIRECTORY_NAME TAG(version) [build-args]`
Refer to the script to get an idea...
<br><br>



<H2>Building an RPM package</H2>
<br><br>
 
 - All source code should reside in the project directory. By default, this directory is /projets, but this is tunable within the Dockerfile (see the ARG "projectdir".

 - The actual build of an RPM package goes beyond the scope of this document. All of my software follow the same directory structure and allows for easy packaging. See https://github.com/jeanfrancoisgratton/dtools : the software is incomplete, but can be packaged on every major distro.

 - The build system is based on tito and follows the usual workflow:
    - tito init
    - tito tag [--keep-version]
    - git push --follow-tags origin
    - tito build --rpm

 
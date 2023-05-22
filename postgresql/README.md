<H1>POSTGRESQL</H1>
<br>

This container is used to create an AlpineLinux-based PostgreSQL 15 database server.

<H2>To configure</H2>
<H3>Files in this directory</H3>
In Dockerfile, replace the following ARG values with values you'd rather use:

- pguser (the pgsql admin user)
- pgpasswd (the pgsql admin user passwd)
- pgport (the port the DB will listen to)
<br><br>

<H2>To build the container</H2>
Go to the parent directory, above this one, and run:
`./build.sh $DIRECTORY_NAME TAG(version) [build-args]`
Refer to the script to get an idea...
<br><br>

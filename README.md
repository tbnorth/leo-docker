# Stand-alone Leo / guacamole docker container

# DOES NOT WORK

See [So close](#so-close).

Read [Security](#security) for security issues.

Leo is a Python / PyQt5 editor / IDE / info. manager: http://leoeditor.com/

Guacamole is a server that serves a web app. that lets you connect
to remote desktops
(e.g. via [VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing)): https://guacamole.apache.org/

This repo. contains a [Dockerfile](./Dockerfile) and some scripts
to run Leo in a VNC session in the same Docker container
that's running guacamole, effectively turning Leo into a web. app.
This repo. builds on https://github.com/oznu/docker-guacamole because
it's a single self contained Docker container, unlike the three
container ecosystem described by the official guacamole Docker instructions.

I guess this would work in Docker for Windows running Linux containers,
which installs a Linux VM in Windows, but I wouldn't try that, this is
only tested with Linux, Ubuntu 18.04, specifically, as the host.  The
Docker container's based on Alpine Linux.

So assuming you have Docker installed and working, clone this repo.,
`cd` into it, and:
```shell
docker build -t leo-editor .
```
which should download a bunch of stuff and create the Docker image
on your local system.  Depending on machine speed / internet speed
it make take some time.

Then create a new folder somewhere else (not in the repo. folder)
and run:
```shell
docker run -it --rm -p 8080:8080 -v $PWD/conf:/conf leo-editor
```
to run the container.  It takes a while to start up, at least 25
seconds.  If you're already running something on port 8080, change
the **first** 8080 in the above to an available port and use that
in the address of the server: http://127.0.0.1:8080/, which you
should visit in a web-browser.

Log in with username/password guacadmin/guacadmin, and if it doesn't immediately
open Leo in the web-browser, try opening the connection called `test`.

When you exit Leo, the whole container exits.

## So close

This almost works, but not quite.  There are three VNC servers in the Alpine
Linux distribution.  Under `vnc4server` and `tigervncserver` PyQt5 seg. faults
when you try and run Leo.  The Dockerfile in this repo. installs `tightvncserver`,
which runs Leo, but the keyboard mapping is hopelessly messed up.  As in you
can't type even plain text.  Fixing this may be as simple as using PyQt4,
I haven't tried that.

## Security

guacadmin/guacadmin is the globally know default login to guacamole, and
may allow others to see stuff on you're machine if (a) you expose it to the
internet, and (b) you have a VNC service running on your machine.  It's a
small manageable risk, but if you don't know about these things and don't
feel comfortable with it, don't do it.


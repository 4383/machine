# machine
Your development environment embedded in a docker container

[![Docker Automated build](https://img.shields.io/docker/automated/4383/machine.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/4383/machine.svg)]()

## Features
- Assigned PID: python/tox process is automatically assigned PID `666`
  No need to search your PID
- Running the docker image automatically launch preconfigured tmux with:
    - list mounted directory
    - show running process
    - perf tools ready to run against PID `666`
    - automatic monitoring context switch of PID `666`
- regexploit ready to run
- valgrind, pysnooper, py-spy, scalene run out of the box
- vim
- oh-my-zsh

## Disclaimers

Using this environment could generate various extra files into
the mounted repository. To avoid tracking these files accidentally,
you can create a global gitignore file that will be applied everywher
you are using `git`. These rules will be used in addition to the ones
provided in the repositories you works on.

First create a `~/.gitignore` file.
Once done, put these extra files patterns into this global gitignore file:

```
profiling.cprof
strace.txt
cmt_msg
.zsh_history
```

Then run this command `git config --global core.excludesFile '~/.gitignore'`.

## Usages

```shell
$ cd python
$ docker build -t machine-python312 .
$ # run the main instance of the dev container with a default dashboard
$ NAME=$(basename $(pwd))_py312; docker run -it --rm --name $NAME --mount type=bind,source="$(pwd)",target=/home/dev/app -e CONTAINER_NAME=$NAME --privileged machine-python312 /bin/bash
$ # run an other shell into this same container
$ docker exec -it dev_python_py312 /bin/bash
$ # stop all the instances of this container
$ docker stop dev_python_py312
```

Running the `docker run` command give you the following dashboard:

![Default dashboard](example.png "Default dashboard")

If you output things in files under `~/app`, then these files will remain
available even after the container shutdown. They will be reloaded at your next container restart.

You may want to trace or monitor things inside your container, so the
following command show you how enabling [eBPF](https://ebpf.io/) and
[BCC](https://github.com/iovisor/bcc) from mounting specific
volumes from your host:

```
NAME=$(basename $(pwd))_py312; docker run -it --rm --name $NAME --mount type=bind,source="$(pwd)",target=/home/dev/app -e CONTAINER_NAME=$NAME -v /lib/modules:/lib/modules:ro -v /usr/src:/usr/src:ro -v /etc/localtime:/etc/localtime:ro -v /usr/share/bcc/tools/:/usr/share/bcc/tools:ro  --privileged machine-python312 /bin/bash
```

This container is built with BCC support. However, your host machine should
be also [setup to support BCC](https://github.com/iovisor/bcc/blob/master/INSTALL.md).

Once your container is running, you can launch eBPF BCC based tracing by
using commands like:

```
$ sudo /usr/share/bcc/tools/runqslower
```

Using `sudo` could be required.

## Demo

Here is a demo of how it works:

[![asciicast](https://asciinema.org/a/0e7cLRsHiNJlBQdlIgdkApAsU.svg)](https://asciinema.org/a/0e7cLRsHiNJlBQdlIgdkApAsU)

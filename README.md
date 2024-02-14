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

## Usages

Python:
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

## Demo

Here is a demo of how it works:

[![asciicast](https://asciinema.org/a/0e7cLRsHiNJlBQdlIgdkApAsU.svg)](https://asciinema.org/a/0e7cLRsHiNJlBQdlIgdkApAsU)

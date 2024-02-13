# machine
Your development environment embedded in a docker container

[![Docker Automated build](https://img.shields.io/docker/automated/4383/machine.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/4383/machine.svg)]()

## Features
- vim
- oh-my-zsh
- preconfigured tmux

## Usages

Python:
```shell
$ cd python
$ docker build -t machine-python312 .
$ # run the main instance of the dev container with a default dashboard
$ docker run -it --rm --name dev_$(basename $(pwd))_py312 -e CONTAINER_NAME=dev_$(basename $(pwd))_py312 --mount type=bind,source="$(pwd)",target=/home/developer/app machine-python312 /bin/bash
$ # run an other shell into this same container
$ docker exec -it dev_python_py312 /bin/bash
$ # stop all the instances of this container
$ docker stop dev_python_py312
```

Running the `docker run` command give you the following dashboard (nested tmux on my local env):

![Default dashboard](example.png "Default dashboard")

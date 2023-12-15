# machine
Your development environment embedded in a docker container

[![Travis](https://img.shields.io/travis/4383/machine.svg)]()
[![Docker Automated buil](https://img.shields.io/docker/automated/4383/machine.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/4383/machine.svg)]()

## Version
v0.3.0

## Features
- vim
- improved bash
- firefox

## Usages

Ubuntu:
```shell
docker build -t machine .
docker run -it 4383/machine:latest
```

Python:

```shell
$ cd python
$ docker build -t machine-python310 .
$ docker run -it --rm --name mpython310 --mount type=bind,source="$(pwd)",target=/home/developer/app machine-python310 /bin/bash
```
## Contribute
- fork this repository
- add your modifications
- send a pull request

## Roadmap
- add atom text editor
- add python installation
- add docker installation

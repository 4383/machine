FROM ubuntu:latest

MAINTAINER hervé beraud <herveberaud.pro@gmail.com>

RUN apt-get update
RUN apt-get install -y firefox
RUN apt-get install vim

RUN useradd -ms /bin/bash developer
RUN export uid=1000 gid=1000
ENV HOME /home/developer

COPY ./.vimrc $HOME
COPY ./.bashrc $HOME

USER developer
WORKDIR $HOME

CMD firefox & /bin/bash

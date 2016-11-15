FROM ubuntu:latest

MAINTAINER hervé beraud <herveberaud.pro@gmail.com>

RUN apt-get update
RUN apt-get install -y firefox
RUN apt-get install vim

RUN useradd -ms /bin/bash developer
RUN export uid=1000 gid=1000

COPY ./.vimrc /etc/vim/vimrc
COPY ./.bashrc /etc/bashrc

USER developer
ENV HOME /home/developer
WORKDIR $HOME

CMD firefox & /bin/bash

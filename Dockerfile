FROM ubuntu:latest

RUN useradd -ms /bin/bash developer

RUN apt-get install vim
COPY ./.vimrc /etc/vim/vimrc
COPY ./.bashrc /etc/bashrc

USER developer
WORKDIR /home/developer

CMD /bin/bash

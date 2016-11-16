###############################################################
#
# ███╗   ███╗ █████╗  ██████╗██╗  ██╗██╗███╗   ██╗███████╗
# ████╗ ████║██╔══██╗██╔════╝██║  ██║██║████╗  ██║██╔════╝
# ██╔████╔██║███████║██║     ███████║██║██╔██╗ ██║█████╗  
# ██║╚██╔╝██║██╔══██║██║     ██╔══██║██║██║╚██╗██║██╔══╝  
# ██║ ╚═╝ ██║██║  ██║╚██████╗██║  ██║██║██║ ╚████║███████╗
# ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝
#                                                       
# Use your development environment anywhere !
# https://github.com/4383/machine
# v0.1.0
# Created by : Hervé BERAUD (4383)
###############################################################
FROM ubuntu:latest

MAINTAINER hervé beraud <herveberaud.pro@gmail.com>

########################
# Install packages
########################
RUN apt-get update
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common
RUN apt-get install -y firefox
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y tmux
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y lynx

########################
# Configure user
########################
RUN useradd -ms /bin/bash developer
RUN export uid=1000 gid=1000
ENV HOME /home/developer

########################
# Configure vim
########################
RUN mkdir -p $HOME/.vim/bundle
RUN mkdir -p $HOME/.vim/autoload
RUN cd $HOME/.vim/bundle && git clone https://github.com/rkulla/pydiction.git
RUN curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

########################
# Configure dropbox
########################
RUN cd $HOME && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
RUN cd /usr/bin && wget -O dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py

########################
# Install atom
########################
RUN curl -SL https://github.com/atom/atom/releases/download/v1.12.3/atom-amd64.deb -o /tmp/atom-amd64.deb
RUN dpkg --install /tmp/atom-amd64.deb
RUN rm -rf /tmp/atom-amd64.deb

########################
# Setup home directory
########################
COPY ./.vimrc $HOME
COPY ./.bashrc $HOME
COPY ./.bash_aliases $HOME
RUN chown -R developer:developer $HOME

USER developer
WORKDIR $HOME
CMD  $HOME/.dropbox-dist/dropboxd && /bin/bash

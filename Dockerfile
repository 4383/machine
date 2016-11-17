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
RUN echo 'deb http://linux.dropbox.com/ubuntu xenial main' >> /etc/apt/source.list
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
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
RUN apt-get install -y ruby
RUN apt-get install -y e2fsprogs
RUN apt-get install -y zsh
RUN apt-get install -y sudo
#RUN apt-get install -y nautilus-dropbox
#RUN apt-get install -y certbot 
#RUN apt-get install -y python-certbot-apache
RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gconf2 \
    gvfs-bin \
    libasound2 \
    libgtk2.0-0 \
    libnotify4 \
    libnss3 \
    libxtst6 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

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
RUN cd /usr && wget -O dropbox.py https://www.dropbox.com/download?dl=packages/dropbox.py

########################
# Install atom
########################
RUN curl -SL https://github.com/atom/atom/releases/download/v1.12.3/atom-amd64.deb -o /tmp/atom-amd64.deb
RUN dpkg --install /tmp/atom-amd64.deb
RUN rm -rf /tmp/atom-amd64.deb

########################
# Install keybase
########################
RUN curl -O https://prerelease.keybase.io/keybase_amd64.deb -o /tmp/keybase_amd64.deb
RUN ls -la /tmp
#RUN dpkg -i /tmp/keybase_amd64.deb 
#RUN cd /tmp && apt-get install -f 
#RUN run_keybase

########################
# Install travis-ci cli
########################
#RUN gem install travis -v 1.8.4 --no-rdoc --no-ri

########################
# Setup home directory
########################
COPY ./.vimrc $HOME
COPY ./.bashrc $HOME
COPY ./.bash_aliases $HOME
RUN uuidgen > ./.uuid
RUN chown -R developer:developer $HOME

#USER developer
WORKDIR $HOME
CMD  sh $HOME/.dropbox-dist/dropboxd && /bin/bash

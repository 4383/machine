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
RUN apt-get install -y python-software-properties \
    software-properties-common \ 
    firefox \
    vim \
    git \
    tmux \
    curl \
    wget \
    python3 \
    python3-pip \
    lynx \
    ruby \
    ruby-dev \
    rubygems \
    e2fsprogs \
    zsh \
    sudo

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
ADD https://www.dropbox.com/download?plat=lnx.x86_64 /dropbox.tgz
RUN tar xfvz /dropbox.tgz && rm /dropbox.tgz

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
RUN gem install travis -v 1.8.4 --no-rdoc --no-ri

########################
# Setup home directory
########################
COPY ./.vimrc $HOME
COPY ./.bashrc $HOME
COPY ./.bash_aliases $HOME
RUN chown -R developer:developer $HOME

USER developer
WORKDIR $HOME
ENV GITUSER "Hervé BERAUD" 
ENV GITMAIL "herveberaud.pro@gmail.com" 
RUN git config --global user.name $GITUSER
RUN git config --global user.email $GITMAIL

CMD  /.dropbox-dist/dropboxd & /bin/bash

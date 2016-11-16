FROM ubuntu:latest

MAINTAINER hervé beraud <herveberaud.pro@gmail.com>

RUN apt-get update
RUN apt-get install -y firefox
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y tmux
RUN apt-get install -y curl
RUN apt-get install -y wget

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
RUN ls -la $HOME
#RUN $HOME/.dropbox-dist/dropboxd

COPY ./.vimrc $HOME
COPY ./.bashrc $HOME

RUN chown -R developer:developer $HOME

USER developer
WORKDIR $HOME

CMD  $HOME/.dropbox-dist/dropboxd && /bin/bash

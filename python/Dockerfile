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
# v0.3.0
# Created by : Hervé BERAUD (4383)
###############################################################
FROM python:3.12-bookworm

MAINTAINER hervé beraud <herveberaud.pro@gmail.com>

RUN apt update -y
RUN apt install -y \
    vim \
    strace \
    tmux \
    tmate \
    curl \
    wget \
    lynx \
    make \
    gcc \
    zsh \
    tree \
    xclip


########################
# Configure user
########################
RUN useradd -ms /bin/bash developer
RUN export uid=1000 gid=1000
ENV HOME /home/developer
RUN chown -R developer:developer $HOME
RUN usermod --shell /bin/zsh developer

########################
# Configure Vim
########################
COPY vimrc HOME/.vimrc

########################
# Setup home directory
########################
COPY ./requirements.txt $HOME
RUN pip3 install -r $HOME/requirements.txt

########################
# Configure zsh
########################
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN echo 'ZSH_THEME="agnoster"' >> ~/.zshrc
RUN echo "export EDITOR=vim" >> ~/.zshrc

########################
# Setup git
########################
ENV GITUSER "Hervé BERAUD" 
ENV GITMAIL "hberaud@redhat.com" 
RUN git config --global user.name $GITUSER && \ 
    git config --global user.email $GITMAIL && \
    git config --global push.default current

########################
# Setup tmux
########################
COPY ./tmuxrc $HOME
COPY ./motd /etc

USER developer
WORKDIR $HOME/app

ENTRYPOINT exec tmux new-session 'tmux source-file ~/tmuxrc'

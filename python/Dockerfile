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
FROM python:3.12-bullseye

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
    xclip \
    aspell \
    less \
    sudo \
    valgrind


########################
# Configure user
########################
RUN useradd -ms /bin/bash dev && \
    echo dev:dev | chpasswd && \
    adduser dev sudo
RUN export uid=1000 gid=1000
ENV HOME /home/dev
RUN chown -R dev:dev $HOME
RUN usermod --shell /bin/zsh dev

########################
# Configure Vim
########################
COPY vimrc $HOME/.vimrc
COPY vimbundle $HOME/.vim/bundle

########################
# Setup home directory
########################
COPY ./requirements.txt $HOME
RUN pip3 install -r $HOME/requirements.txt

########################
# Configure zsh
########################
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY zshrc $HOME/.zshrc
COPY agnoster.zsh-theme $HOME/.oh-my-zsh/themes/agnoster.zsh-theme

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

USER dev
WORKDIR $HOME/app

ENTRYPOINT exec tmux new-session 'tmux source-file ~/tmuxrc'

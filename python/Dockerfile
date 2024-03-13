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

RUN echo "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye main" >> /etc/apt/sources.list
RUN echo "deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main" >> /etc/apt/sources.list
RUN echo "deb http://cloudfront.debian.net/debian stable main" >> /etc/apt/sources.list
RUN echo "deb [trusted=yes] http://repo.iovisor.org/apt/trusty trusty-nightly main" > /etc/apt/sources.list.d/iovisor.list



RUN wget https://apt.llvm.org/llvm-snapshot.gpg.key -O llvm-snapshot.gpg.key
RUN apt-key add llvm-snapshot.gpg.key

RUN apt update -y
#RUN apt upgrade -y
RUN apt install -y \
    libllvm-15-ocaml-dev \
    libllvm15 \
    llvm-15 \
    llvm-15-dev \
    llvm-15-doc \
    llvm-15-examples \
    llvm-15-runtime \
    clang \
    lldb \
    lld \
    gcc-multilib
RUN apt install -y \
    bpfcc-tools \
    libbpfcc \
    libbpfcc-dev \
    linux-headers-generic \
    libelf-dev
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
    valgrind \
    net-tools \
    python3-dev \
    gcc-10-plugin-dev \
    bpftrace \
    python3-dbg \
    locate \
    tcpdump \
    lsof \
    telnet


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
COPY ./requirements.txt $HOME/.requirements.txt
RUN pip3 install -r $HOME/.requirements.txt

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
COPY ./tmuxrc $HOME/.tmuxrc
COPY ./motd /etc

USER dev
WORKDIR $HOME/app

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ENTRYPOINT exec tmux new-session 'tmux source-file ~/.tmuxrc'

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
FROM python:3.11-bookworm

MAINTAINER hervé beraud <herveberaud.pro@gmail.com>

########################
# Configure user
########################
RUN useradd -ms /bin/bash developer
RUN export uid=1000 gid=1000
ENV HOME /home/developer
RUN chown -R developer:developer $HOME

########################
# Setup home directory
########################
COPY ./requirements.txt $HOME
RUN pip3 install -r $HOME/requirements.txt

USER developer
WORKDIR $HOME

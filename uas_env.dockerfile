# https://www.howtoforge.com/tutorial/how-to-create-docker-images-with-dockerfile-18-04/

# tensorflow cpu docker [https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/dockerfiles/dockerfiles/cpu.Dockerfile]

#setting user as non-root: 
#https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user

# RUN instruction Dockerfile for Docker Quick Start
# to run:
# docker build -t drone_custon_training:1.0 -f "dockerfile" .
# docker run --rm -it drone_custom_training:1.0
ARG UBUNTU_VERSION=18.04



FROM ubuntu:${UBUNTU_VERSION} as base
# For creating non-root users
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
&& useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Add a fun prompt for dev user of my-app
# whale: "\xF0\x9F\x90\xB3"
# alien:"\xF0\x9F\x91\xBD"
# fish:"\xF0\x9F\x90\xA0"
# elephant:"\xF0\x9F\x91\xBD"
# moneybag:"\xF0\x9F\x92\xB0"
# RUN echo 'PS1="\[$(tput bold)$(tput setaf 4)\]my-app $(echo -e "\xF0\x9F\x90\xB3") \[$(tput sgr0)\] [\\u@\\h]:\\W \\$ "' 

# Custom bash prompt via kirsle.net/wizards/ps1.html
# https://ss64.com/bash/syntax-prompt.html
RUN echo 'PS1="[$(echo -e "\xF0\x9F\x92\xB0")\[$(tput setaf 1)\]\u\[$(tput setaf 3)\]@\[$(tput setaf 2)\]\h\[$(tput sgr0)\]:\[$(tput setaf 6)\]\w\[$(tput setaf 3)\]$(git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1)/")\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"' >> /home/$USERNAME/.bashrc && \
    echo 'alias ls="ls --color=auto"' >> /home/$USERNAME/.bashrc 
    
# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

# install python3.8 and set it as default
RUN apt-get update -y && \
    apt install --no-install-recommends -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa -y && \ 
    apt-get update -y && \
    apt-get install --no-install-recommends -y \
    python3.8 \
    python3-dev && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2 && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    git \
    python3-pip \
    python3-setuptools \
    build-essential \
    ffmpeg \
    curl && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

# # Some TF tools expect a "python" binary
RUN ln -s $(which python3.8) /usr/local/bin/python

# pip stuff
RUN python -m pip install --upgrade pip && \
    python -m pip --no-cache-dir install --upgrade \
    "pip<20.3" \
    setuptools \
    numpy \
    Pillow \
    matplotlib \
    cycler \
    tensorflow==2.6 \
    gym \
    pybullet \
    stable_baselines3 \
    'ray[rllib]'
    
COPY bashrc /etc/bash.bashrc
RUN chmod a+rwx /etc/bash.bashrc

RUN git clone https://github.com/utiasDSL/gym-pybullet-drones.git && \
    cd gym-pybullet-drones/ && \
    python -m pip install -e .

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

CMD ["/bin/bash"]

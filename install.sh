#!/bin/bash -e

export PACKAGES="\
    coreutils \
    sudo \
    git \
    openssh-client \
    ca-certificates \
    musl \
    linux-headers \
    build-base \
    python2 \
    python2-dev \
    py-pip \
    nodejs \
"

apk update

echo "================ installing packages ======================="
apk add --no-cache $PACKAGES

echo "================ make some useful symlinks that are expected to exist ======================="
if [[ ! -e /usr/bin/python ]];        then ln -sf /usr/bin/python2.7 /usr/bin/python; fi
if [[ ! -e /usr/bin/python-config ]]; then ln -sf /usr/bin/python2.7-config /usr/bin/python-config; fi
if [[ ! -e /usr/bin/easy_install ]];  then ln -sf /usr/bin/easy_install-2.7 /usr/bin/easy_install; fi

echo "================ install and upgrade pip ======================="
easy_install pip
pip install --upgrade pip
if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip2.7 /usr/bin/pip; fi

echo "================ install python packages ======================="
pip install requests

echo "================ test ssh ======================="
eval `ssh-agent -s`
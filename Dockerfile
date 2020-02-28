FROM balenalib/raspberry-pi:buster
MAINTAINER Nilson Oliveira <nilson.oliveira@fpf.br>

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y \
    software-properties-common
RUN apt-get update && apt-get install -y \
		dh-virtualenv \ 
		autoconf \
		python3-venv \
		python3 \
		python3-setuptools \
		python3-setuptools-git \
		python3-dev \
		python3-pip \
		build-essential \
		ca-certificates \
		curl \
		imagemagick \
		libbz2-dev \
		libcurl4-openssl-dev \
		libevent-dev \
		libglib2.0-dev \
		libjpeg-dev \
		libmagickcore-dev \
		libmagickwand-dev \
		libncurses-dev \
		libpq-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libxml2-dev \
		libxslt-dev \
		libyaml-dev \
		libzmq-dev \
		libffi-dev \
		zlib1g-dev \
		git \
		devscripts \
		equivs \
		wget \
		vim \
		openssh-client \
		cython3 \
		python3-zmq \
		python3-cffi \
		webp \
	&& rm -rf /var/lib/apt/lists/*

RUN pip3 install pyzmq

RUN apt-get update
RUN apt-get install -y git build-essential libtool autoconf automake pkg-config unzip libkrb5-dev
RUN cd /tmp && git clone git://github.com/jedisct1/libsodium.git && cd libsodium && git checkout e2a30a && ./autogen.sh && ./configure && make check && make install && ldconfig
RUN cd /tmp && git clone --depth 1 git://github.com/zeromq/libzmq.git && cd libzmq && ./autogen.sh && ./configure && make -j4
# RUN cd /tmp/libzmq && make check
RUN cd /tmp/libzmq && make install && ldconfig
RUN rm /tmp/* -rf

RUN [ "cross-build-end" ]

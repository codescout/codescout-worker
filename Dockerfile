FROM ubuntu:14.04
MAINTAINER Dan Sosedoff "dan@doejo.com"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale

RUN apt-get update
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
RUN apt-get install -y wget curl git-core software-properties-common

RUN apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby2.1 ruby2.1-dev

RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc
RUN gem update --system

ADD . /app
WORKDIR /app
RUN bundle install --path .bundle -j4 --deployment
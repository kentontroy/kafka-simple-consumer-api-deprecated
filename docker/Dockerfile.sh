#!/bin/bash

cat <<EOF > Dockerfile
FROM openjdk:8

RUN apt-get -y update
RUN apt-get -y install vim nano
RUN mkdir -p /usr/local/src/offsetshell/bin
RUN mkdir /usr/local/src/offsetshell/depends

COPY sasl.properties /usr/local/src/offsetshell
COPY GetOffsetShell.sh /usr/local/src/offsetshell/bin 
COPY depends/ /usr/local/src/offsetshell/depends

WORKDIR /usr/local/src/offsetshell/bin

ENV OFFSET_SHELL_HOME /usr/local/src/offsetshell

EOF

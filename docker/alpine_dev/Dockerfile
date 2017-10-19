# docker build -t alpine_dev .
# docker run -it alpine_dev bash
# docker run -it -v ~/git/:/home/markus/git/ -p 8080:8080 alpine_dev bash

FROM alpine:latest
MAINTAINER Markus Bergholz <markuman@gmail.com>

RUN apk update
RUN apk add bash git screen htop ncdu wget nano nodejs bash-completion
RUN rm -rf /var/cache/apk/*
# alpine-sdk
RUN adduser -h /home/markus -s /bin/bash -G users -u 1000 -S -D markus
USER markus
WORKDIR /home/markus
COPY .bashrc /home/markus/
CMD /bin/bash --login 
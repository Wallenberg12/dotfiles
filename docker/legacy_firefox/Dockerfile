# docker build -t legacy_firefox .
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix legacy_firefox

FROM ubuntu:14.04

RUN apt-get update && \
        apt-get install -y firefox && \
        apt-get clean

RUN groupadd --gid 1000 user && \
        useradd --uid 1000 --gid 1000 --create-home user

USER user
CMD /usr/bin/firefox


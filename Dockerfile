FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:99

RUN apt-get update && \
    apt-get install -y xterm openssl inetutils-ping libjpeg8-dev libxml2 xvfb && \
    apt-get install -y vim less wget

COPY ptools-init.dat /opt/data/ptools-local/ptools-init.dat
COPY install-pathway-tools.sh /opt/bin/install-pathway-tools.sh
COPY run-pathway-tools.sh /opt/bin/run-pathway-tools.sh
COPY pathway-tools-21.0-linux-64-tier1-install /opt/bin/pathway-tools-21.0-linux-64-tier1-install

RUN /opt/bin/install-pathway-tools.sh

CMD [ "/opt/bin/run-pathway-tools.sh" ]
#
# /opt/data/ptools-local/ptools-init.dat
#
# WWW-Server-Hostname pathway.tony.nersc.gov
# WWW-Server-Port 80

#
# docker build -t pathway:21.0 .
# docker run --volume `pwd`:/mnt --publish 1555:1555 --rm --name pathway -it pathway:21.0 /bin/bash
# > cd /mnt
# > ./pathway-tools-21.0-linux-64-tier1-install
# <enter>
# /opt/data
# <enter>
# n
# y
# n

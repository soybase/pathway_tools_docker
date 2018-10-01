FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:99

ARG ptools_install
ARG without_biocyc

RUN apt-get update && \
    apt-get install -y xterm openssl inetutils-ping libjpeg8-dev libxm4 libxml2 xvfb && \
    apt-get install -y vim less wget \
    && rm -rf /var/lib/apt/lists

COPY run-pathway-tools.sh /opt/bin/run-pathway-tools.sh
COPY ${ptools_install} /tmp/

RUN /tmp/${ptools_install} --mode unattended --PTOOLS_LOCAL_PATH /opt/ \
    && rm /tmp/${ptools_install} \
    && if [ "${without_biocyc:-}" ]; then rm -rf /opt/pathway-tools/aic-export/pgdbs/biocyc; fi

ENTRYPOINT ["/opt/bin/run-pathway-tools.sh"]
CMD []
EXPOSE 1555
#
# docker build --build-arg without_biocyc=1 --build-arg ptools_install=pathway-tools-22.5-linux-64-tier1-install -t pathway:22.5 .
# docker run --volume `pwd`:/mnt --publish 1555:1555 --rm --name pathway -it pathway:22.5

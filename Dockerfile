# syntax=docker/dockerfile:experimental
FROM ubuntu:18.04

RUN apt update -qq && apt install -y --no-install-recommends \
  inetutils-ping \
  libjpeg8-dev \
  libxm4 \
  libxml2 \
  openssl1.0 \
  xterm \
  xvfb \
  && rm -rf /var/lib/apt/lists

# set without_biocyc=1 to reduce space used by image
ARG without_biocyc

RUN --mount=type=bind,source=ptools-install,target=/ptools-install \
  /ptools-install/pathway-tools-*-install --mode unattended --PTOOLS_LOCAL_PATH /opt/ \
  && if [ "${without_biocyc}" ]; then rm -rf /opt/pathway-tools/aic-export/pgdbs/biocyc; fi

ENV DISPLAY=:99

COPY run-pathway-tools.sh /opt/bin/run-pathway-tools.sh

ENTRYPOINT ["/opt/bin/run-pathway-tools.sh"]
CMD []
EXPOSE 1555
#
# docker build --build-arg without_biocyc=1 -t pathway:23.5 .

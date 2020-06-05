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

# set without_biocyc=1 to reduce space used by image and startup time of container
ARG without_biocyc=1

RUN --mount=type=bind,source=ptools-install,target=/ptools-install \
  /ptools-install/pathway-tools-24.0-linux-64-tier1-install --mode unattended --PTOOLS_LOCAL_PATH /opt/ \
  && if [ "${without_biocyc}" ]; then rm -rf /opt/pathway-tools/aic-export/pgdbs/biocyc; fi

ENTRYPOINT ["xvfb-run", "/opt/pathway-tools/pathway-tools", "-www"]
EXPOSE 1555

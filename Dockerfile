FROM node:lts-slim
MAINTAINER Richard <nibocn@gmail.com>

ARG GITBOOK_VERSION=3.2.3

RUN apt-get update -y \
    && apt-get install -y calibre-bin graphviz \
    && apt-get install -y fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho \
                          fonts-ipafont-gothic fonts-unfonts-core \
    && npm install -g gitbook-cli gitbook-pdfgen svgexport \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN gitbook fetch ${GITBOOK_VERSION}

EXPOSE 4000

RUN mkdir /book
WORKDIR /book

CMD ["gitbook", "--help"]

FROM ubuntu:latest
MAINTAINER Richard <nibocn@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ARG GITBOOK_VERSION=3.2.3
ARG NODE_VERSION=v10.16.0


RUN \
    apt-get update -y \
    && apt-get install -y calibre-bin graphviz curl \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN \
    # Install Nodejs
    mkdir -p /opt/nodejs \
    && curl http://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz | tar -xzC /opt/nodejs --strip-components=1

ENV PATH="/opt/nodejs/bin:${PATH}"

# Install gitbook
RUN \
    npm install -g gitbook-cli \
    && gitbook fetch ${GITBOOK_VERSION}


# Install fonts
RUN apt-get update -y \
    && apt-get install -y fontconfig \
        \
    # 安装中文字体
    && apt-get install -y fonts-arphic-ukai fonts-arphic-uming \
        \
    # 安装日文字体
    && apt-get install -y fonts-ipafont fonts-ipaexfont \
    && fc-cache -fv \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Java JRE Install
RUN apt-get update -y \
    && apt-get install -y default-jre \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Install npm package
RUN npm install --unsafe-perm -g svgexport \
    && npm install -g node-plantuml

ENV BOOKDIR /book

VOLUME $BOOKDIR

EXPOSE 4000 35729

WORKDIR $BOOKDIR

CMD ["gitbook", "--help"]

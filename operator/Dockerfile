FROM ubuntu:16.04

RUN apt-get -yqq update && apt-get -yqq install docker.io npm
RUN apt-get -yqq install curl
RUN npm install -g n
RUN n stable

RUN mkdir /operator
COPY main.js /operator/main.js
COPY package.json /operator/package.json
COPY package-lock.json /operator/package-lock.json

WORKDIR /operator
RUN npm install
VOLUME /var/run/docker.sock
ENTRYPOINT ["node", "main.js"]

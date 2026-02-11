FROM dpthub/dpt7-node-base 
COPY ./deployment/package.json /opt/
COPY ./deployment/index.js /opt/
COPY ./build/ /opt/dist
COPY ./deployment/node_modules/ /opt/node_modules
WORKDIR /opt
CMD ["npm","start"]


FROM ubuntu:24.04

WORKDIR /opt

ENV PATH=/opt/node-v22.22.0-linux-x64/bin:$PATH

ADD https://nodejs.org/dist/v22.22.0/node-v22.22.0-linux-x64.tar.xz /opt/
RUN apt update && apt install xz-utils && tar -xf /opt/node-v22.22.0-linux-x64.tar.xz
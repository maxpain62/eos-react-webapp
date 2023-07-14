FROM amazonlinux:2
MAINTAINER PR Reddy "trainings@edwiki.in"
RUN yum install tar -y
RUN yum install wget -y
RUN yum install xz -y
RUN wget https://nodejs.org/dist/v16.18.0/node-v16.18.0-linux-x64.tar.xz
RUN tar -xvf /node-v16.18.0-linux-x64.tar.xz
ENV PATH $PATH:/node-v16.18.0-linux-x64/bin
RUN mkdir /opt/dist
RUN mkdir /opt/node_modules
COPY ./deployment/package.json /opt/
COPY ./deployment/index.js /opt/
COPY ./build/ /opt/dist
COPY ./deployment/node_modules/ /opt/node_modules
WORKDIR /opt
CMD ["npm","start"]
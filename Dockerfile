FROM maxpain62/node:16.20.2

COPY ./deployment/package.json /opt/
COPY ./deployment/index.js /opt/
COPY ./deployment/node_modules/ /opt/node_modules
COPY ./build/ /opt/dist

CMD ["npm","start"]
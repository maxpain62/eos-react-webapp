FROM nginx:1.28.2-alpine3.23-slim

COPY ./build/ /usr/share/nginx/html/
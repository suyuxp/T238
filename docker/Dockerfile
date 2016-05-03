FROM node:5-wheezy

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

WORKDIR /opt
COPY package.json ./package.json
RUN npm install cnpm -g --registry=https://registry.npm.taobao.org && cnpm install

COPY assets ./assets
COPY tasks ./tasks

COPY api ./api
COPY views ./views
COPY config ./config

COPY app.js ./app.js

COPY docker/connections.js ./config/connections.js

EXPOSE 1337
CMD npm start

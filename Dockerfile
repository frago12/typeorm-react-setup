FROM node:10.16.0-alpine

RUN apk add --update --no-cache \
  python \
  make \
  g++

EXPOSE 3000

COPY ./api /usr/src/web
WORKDIR /usr/src/web

RUN npm ci
RUN npm run build
# RUN npm run test

RUN npm prune --production

USER node

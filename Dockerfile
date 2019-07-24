FROM node:10.16.0-alpine

RUN apk add --update --no-cache \
  python \
  make \
  g++

EXPOSE 3001

# copy frontend
COPY ./webapp/build /usr/src/web/public

# build api
COPY ./api /usr/src/web
WORKDIR /usr/src/web

RUN npm ci
RUN npm run build
# RUN npm run test

RUN npm prune --production

USER node

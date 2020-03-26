FROM node:alpine

RUN apk update && apk upgrade && apk add --no-cache bash git openssh

WORKDIR "/renovate"
COPY package.json .
COPY package-lock.json .

RUN npm install

ENTRYPOINT sh

FROM node:13.12.0-stretch

WORKDIR "/renovate"
COPY package.json .
COPY package-lock.json .

RUN npm install

ENTRYPOINT bash

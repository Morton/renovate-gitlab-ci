FROM node:13.14.0-stretch

WORKDIR "/renovate"
COPY do-rebase .
COPY do-renovate .
ENV PATH="/renovate:${PATH}"

COPY package.json .
COPY package-lock.json .

RUN npm install

ENTRYPOINT bash

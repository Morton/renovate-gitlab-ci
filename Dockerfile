FROM node:16.11.1-stretch

WORKDIR "/renovate"
COPY do-rebase .
RUN apt-get update -y && apt-get install -y jq
COPY do-renovate .
ENV PATH="/renovate:${PATH}"

COPY package.json .
COPY package-lock.json .

RUN npm install

ENTRYPOINT bash

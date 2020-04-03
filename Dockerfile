FROM node:13.12.0-stretch

WORKDIR "/renovate"
COPY do-renovate .
ENV PATH="/renovate:${PATH}"

COPY package.json .
COPY package-lock.json .

RUN npm install --production

ENTRYPOINT bash

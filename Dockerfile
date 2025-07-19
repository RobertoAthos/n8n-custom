FROM node:20.19.0-alpine

ARG N8N_VERSION=1.102.4

RUN if [ -z "$N8N_VERSION" ] ; then echo "The N8N_VERSION argument is missing!" ; exit 1; fi

RUN apk add --no-cache graphicsmagick tzdata

RUN apk add --no-cache --virtual build-dependencies python3 build-base ca-certificates && \
    npm_config_user=root npm install -g n8n@${N8N_VERSION} && \
    apk del build-dependencies

RUN mkdir -p /data && chown node:node /data

WORKDIR /data

ENV N8N_ENV=production

USER node

CMD ["n8n"]

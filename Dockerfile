# syntax = docker/dockerfile:1.0.1
FROM node:10 as builder
WORKDIR /usr/src/app
COPY package.json .
RUN yarn install
COPY app.js .
COPY test .
RUN npm test

FROM balenalib/armv7hf-alpine-node:10-3.8 as arm
COPY --from=builder /usr/src/app/node_modules node_modules
COPY --from=builder /usr/src/app/package.json .
COPY --from=builder /usr/src/app/app.js .
ARG CREATION_DATE
ARG REVISION
LABEL org.opencontainers.image.ref.name=express-demo
LABEL org.opencontainers.image.source=https://github.com/bjornmagnusson/express-demo
LABEL org.opencontainers.image.created=$CREATION_DATE
LABEL org.opencontainers.image.revision=$REVISION

FROM node:10 as standard
COPY --from=builder /usr/src/app/node_modules node_modules
COPY --from=builder /usr/src/app/package.json .
COPY --from=builder /usr/src/app/app.js .
ARG CREATION_DATE
ARG REVISION
LABEL org.opencontainers.image.ref.name=express-demo
LABEL org.opencontainers.image.source=https://github.com/bjornmagnusson/express-demo
LABEL org.opencontainers.image.created=$CREATION_DATE
LABEL org.opencontainers.image.revision=$REVISION

EXPOSE 3000
CMD [ "npm", "start" ]

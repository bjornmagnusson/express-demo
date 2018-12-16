# syntax = docker/dockerfile:1.0.0
FROM node:10
ARG CREATION_DATE
ARG REVISION
LABEL org.opencontainers.image.ref.name=express-demo
LABEL org.opencontainers.image.source=https://github.com/bjornmagnusson/express-demo

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json .
# For npm@5 or later, copy package-lock.json as well
# COPY package.json package-lock.json .

RUN npm install

# Bundle app source
COPY . .

LABEL org.opencontainers.image.created=$CREATION_DATE
LABEL org.opencontainers.image.revision=$REVISION

EXPOSE 3000
CMD [ "npm", "start" ]

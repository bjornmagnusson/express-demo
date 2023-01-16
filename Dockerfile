# syntax = docker/dockerfile:1.0.1
FROM node:14 as builder
WORKDIR /usr/src/app
COPY package.json .
RUN yarn install
COPY app.js .

FROM balenalib/armv7hf-alpine-node:10-3.8 as arm
COPY --from=builder /usr/src/app/node_modules node_modules
COPY --from=builder /usr/src/app/package.json .
COPY --from=builder /usr/src/app/app.js .
EXPOSE 3000
CMD [ "npm", "start" ]

FROM node:14 as standard
COPY --from=builder /usr/src/app/node_modules node_modules
COPY --from=builder /usr/src/app/package.json .
COPY --from=builder /usr/src/app/app.js .
EXPOSE 3000
CMD [ "npm", "start" ]

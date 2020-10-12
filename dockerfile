FROM alpine

# Copy CA from ./cert
COPY ./linux-files /ca-tools

RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk add openssl


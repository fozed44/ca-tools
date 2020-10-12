FROM alpine

RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk add openssl


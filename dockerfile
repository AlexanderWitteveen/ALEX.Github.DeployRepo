FROM alpine:3.15

COPY entrypoint.sh /entrypoint.sh

RUN apk add bash git openssh  

ENTRYPOINT ["/entrypoint.sh"]

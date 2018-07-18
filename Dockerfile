FROM nginx:1.14.0-alpine

ARG BITLY_VERSION=2.2.0

RUN apk add --no-cache \
    ca-certificates \
    supervisor \
    curl

ADD supervisord.conf /etc/supervisord.conf

# Download bitly binary and unzip it
RUN curl -sL https://github.com/bitly/oauth2_proxy/releases/download/v2.2/oauth2_proxy-${BITLY_VERSION}.linux-amd64.go1.8.1.tar.gz| tar xvz --strip 1 -C /usr/bin

EXPOSE 4180
CMD /usr/bin/supervisord -n -c /etc/supervisord.conf

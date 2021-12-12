# base image
FROM alpine:3.14

# set vault version
# TODO set in central config
ENV VAULT_VERSION 1.8.2

# download dependencies
RUN apk --no-cache add \
      bash \
      ca-certificates \
      wget

# create a new directory
RUN mkdir /vault

# create a new directory
RUN mkdir /vault/config

# download and set up vault
# TODO use staged docker build
RUN wget --quiet --output-document=/tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip /tmp/vault.zip -d /vault && \
    rm -f /tmp/vault.zip && \
    chmod +x /vault

# update PATH
ENV PATH="PATH=$PATH:$PWD/vault"

# add the config file
#COPY ./config/vault-config.json /vault/config/vault-config.json

# expose port 8200
EXPOSE 8200

# run vault
ENTRYPOINT ["vault"]

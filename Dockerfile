FROM ubuntu:16.04 

MAINTAINER etherfuse

ARG passphrase 
ARG private_key 

ENV file ${file:-ENVIRONMENT_VARIABLE_FILE_NOT_SET}
ENV home /notary
ENV passphrase $passphrase

WORKDIR $home

COPY $private_key $home

RUN gpg --import $private_key

RUN rm $private_key

CMD gpg --batch --yes --passphrase=$passphrase --no-use-agent -ab $file





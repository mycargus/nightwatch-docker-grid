FROM node:latest

USER root

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY ./package.json $APP_HOME
RUN npm install --ignore-scripts --unsafe-perm --loglevel warn
COPY . $APP_HOME

RUN groupadd -r docker && useradd -r -g docker docker

RUN chown -R docker:docker $APP_HOME
USER docker
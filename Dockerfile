FROM node:latest

USER root

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY . $APP_HOME
ADD scripts/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

RUN groupadd -r docker && useradd -r -g docker docker

RUN chown -R docker:docker /home $APP_HOME/..
USER docker

ENTRYPOINT ["/entrypoint.sh"]


FROM alpine:latest

####
# pre-installation
####

USER root

ENV HOME /home
ENV USER docker
ENV APP_DIR $HOME/$USER/app

# http://pkg-shadow.alioth.debian.org/features.php
ENV TEMPORARY_DEPENDENCIES='shadow'
RUN apk update && apk --no-cache add ${TEMPORARY_DEPENDENCIES}
# add user as per: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#user
RUN groupadd -r $USER && useradd --no-log-init -r -g $USER $USER


###
# nodejs installation
###

RUN apk --no-cache add \
    nodejs-current \
    nodejs-current-npm \
    # clean up obsolete files
    && rm -rf /tmp/* /root/.npm


####
# post-installation
####

# clean no longer needed dependencies
RUN apk del ${TEMPORARY_DEPENDENCIES}


####
# user and content management
####

# create dedicated directory
RUN mkdir -p $APP_DIR
RUN mkdir -p $APP_DIR/tests_output/screenshots
ADD scripts/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

# copy package.json to image
ADD package.json $APP_DIR
# change rights of the folder containing the newly copied content
RUN chown -R $USER $HOME
# switch to docker user to ensure correct permissions for npm dependencies
USER $USER

WORKDIR $APP_DIR

RUN npm install --ignore-scripts --unsafe-perm --loglevel warn

# add rest of repo to image (doing this after installing npm dependencies
# makes for a faster development workflow because only a change to package.json
# will force docker to rebuild the "npm install" layer above)
USER root
ADD . $APP_DIR

# switch back to the docker user
USER $USER

ENTRYPOINT ["/entrypoint.sh"]

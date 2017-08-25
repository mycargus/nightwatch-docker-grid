FROM alpine:latest

####
# pre-installation
####

USER root

ENV USER docker
ENV HOME /home
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

# cleaning no more needed dependecies
RUN apk del ${TEMPORARY_DEPENDENCIES}


####
# user and content management
####

# create dedicated directory
RUN mkdir -p $APP_DIR
ADD scripts/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
# copy local host content to container
COPY . $APP_DIR
# change rights of the folder containing the newly copied content
RUN chown -R $USER $HOME
# finally switch to newly created user
USER $USER

WORKDIR $APP_DIR

ENTRYPOINT ["/entrypoint.sh"]

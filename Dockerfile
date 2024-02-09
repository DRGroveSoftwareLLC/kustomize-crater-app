ARG CRATER_APP_VERSION
ARG user

FROM drgrovellc/crater-app-base:${CRATER_APP_VERSION}
ARG CRATER_APP_VERSION
ARG user

COPY --chown=${user}:www-data crater-${CRATER_APP_VERSION}/ /var/www/

USER root
RUN cp /var/www/docker-compose/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini

RUN composer install --no-interaction --prefer-dist --optimize-autoloader

WORKDIR /var/www/
USER ${user}

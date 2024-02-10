ARG CRATER_APP_VERSION
ARG user

FROM drgrovellc/crater-app-base:${CRATER_APP_VERSION}
ARG CRATER_APP_VERSION
ARG user

USER root
COPY --chown=${user}:www-data crater-${CRATER_APP_VERSION}/ /var/www/
RUN mkdir -p /var/www/vendor && chown -R ${user}:www-data /var/www/vendor

RUN cp /var/www/docker-compose/php/uploads.ini /usr/local/etc/php/conf.d/uploads.ini

WORKDIR /var/www/
USER ${user}

RUN composer install --no-interaction --prefer-dist --optimize-autoloader

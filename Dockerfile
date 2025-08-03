FROM php:7.4-cli-alpine

RUN apk add git
RUN git clone https://github.com/rathena/FluxCP /fluxcp

RUN apk add --no-cache tini zip libzip-dev libpng-dev
RUN docker-php-ext-configure zip
RUN docker-php-ext-install pdo pdo_mysql zip gd mysqli

COPY ./config/application-env.php ./config/servers-env.php /fluxcp/config/

RUN sed -i 's/application.php/application-env.php/g' /fluxcp/index.php && \
    sed -i 's/servers.php/servers-env.php/g' /fluxcp/index.php

ENV BASE_PATH="" \
    SITE_TITLE="Flux Control Panel" \
    INSTALLER_PASSWORD=secretpassword

ENV RO_SERVER_NAME="FluxRO" \
    DATABASE_HOST=localhost \
    DATABASE_USER=ragnarok \
    DATABASE_PASS=ragnarok \
    DATABASE_NAME=ragnarok \
    LOG_DATABASE_HOST=localhost \
    LOG_DATABASE_USER=ragnarok \
    LOG_DATABASE_PASS=ragnarok \
    LOG_DATABASE_NAME=ragnarok \
    LOGIN_SERVER_HOST=localhost \
    CHAR_SERVER_HOST=localhost \
    MAP_SERVER_HOST=localhost

EXPOSE 80

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/start.sh"]

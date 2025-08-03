FROM php:7.4-cli-alpine AS builder

RUN apk add --no-cache git libzip-dev libpng-dev zip \
    && git clone https://github.com/rathena/FluxCP /fluxcp --depth=1 \
    && rm -rf /fluxcp/.git

RUN docker-php-ext-configure zip && \
    docker-php-ext-install pdo pdo_mysql zip gd mysqli

FROM php:7.4-cli-alpine

RUN apk add --no-cache tini zip libpng libzip

COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=builder /fluxcp /fluxcp

COPY ./config/application-env.php ./config/servers-env.php /fluxcp/config/

RUN sed -i 's/application.php/application-env.php/g' /fluxcp/index.php && \
    sed -i 's/servers.php/servers-env.php/g' /fluxcp/index.php

ENV BASE_PATH="" \
    SITE_TITLE="Flux Control Panel" \
    INSTALLER_PASSWORD=secretpassword \
    RO_SERVER_NAME="FluxRO" \
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

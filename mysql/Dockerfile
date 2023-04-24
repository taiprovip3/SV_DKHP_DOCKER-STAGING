FROM mysql:5.7

ENV MYSQL_ROOT_USER=root \
    MYSQL_DATABASE=sv_dkhp \
    MYSQL_CHARSET=utf8 \
    MYSQL_COLLATION=utf8_general_ci \
    MYSQL_ALLOW_EMPTY_PASSWORD=true \
    MYSQL_ROOT_PASSWORD=""

COPY ./init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306

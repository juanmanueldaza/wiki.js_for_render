FROM requarks/wiki:2.5
ARG db_name
ENV DB_NAME=$db_name
ARG db_host
ENV DB_HOST=$db_host
ARG db_port
ENV DB_PORT=$db_port
ARG db_user
ENV DB_user=$db_user
ARG db_pass
ENV DB_PASS=$db_pass
ARG db_type
ENV DB_TYPE=$sqlite
# USER root
# RUN apk add --update curl && \
#     rm -rf /var/cache/apk/*
# RUN apk add curl
# RUN curl -s -L https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 -o confd && chmod +x confd
# USER node
# COPY config.yml.tmpl /etc/confd/templates/config.yml.tmpl
# COPY config.toml /etc/confd/conf.d/config.yml.toml
# RUN ./confd -onetime -backend env
RUN sh

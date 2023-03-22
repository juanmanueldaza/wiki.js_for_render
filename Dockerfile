# Use Node.js v14 as the base image
FROM node:14-alpine

# Set the working directory to /app
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    ffmpeg \
    ghostscript \
    icu-libs \
    imagemagick \
    jq \
    libjpeg-turbo \
    libpng \
    libwebp \
    openssl \
    poppler-utils \
    python3 \
    ttf-freefont \
    tzdata

# Set up configuration for the database
ARG db_name
ARG db_host
ARG db_port
ARG db_user
ARG db_pass
ARG db_type

ENV DB_NAME=$db_name \
    DB_HOST=$db_host \
    DB_PORT=$db_port \
    DB_USER=$db_user \
    DB_PASS=$db_pass \
    DB_TYPE=$db_type

# Download and install ConfD
ENV CONFD_VERSION 0.16.0
RUN curl -sSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /usr/local/bin/confd \
    && chmod +x /usr/local/bin/confd

# Copy configuration files
COPY config.yml.tmpl /etc/confd/templates/config.yml.tmpl
COPY config.toml /etc/confd/conf.d/config.yml.toml

# Copy the application files into the container
COPY . .

# Install the application dependencies
RUN npm install --production

# Set the default command to run the application
CMD [ "npm", "start" ]

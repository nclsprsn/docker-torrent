FROM alpine:3.6

ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV UID=1000 \
    GID=1000

RUN apk update && \
    apk add --no-cache \
        bash \
        curl \
        ffmpeg \
        geoip \
        libc6-compat \
        nginx \
        openrc \
        php7 \
        php7-fpm \
        php7-json \
        rtorrent \
        screen \
        sox \
        tar \
        unrar \
        unzip \
        zip && \
    apk add --no-cache \
        --repository http://nl.alpinelinux.org/alpine/edge/community \
        mediainfo

RUN mkdir -p \
	    /usr/share/nginx/html/rutorrent && \
    curl -o \
        /tmp/rutorrent.tar.gz -L \
	    "https://github.com/Novik/ruTorrent/archive/master.tar.gz" && \
    tar xzf \
        /tmp/rutorrent.tar.gz -C \
	    /usr/share/nginx/html/rutorrent --strip-components 1 && \
    rm -rf /tmp/*.tar.gz

# Add the s6 binaries fs layer
COPY s6-overlay-v1.21.2.0-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-v1.21.2.0-amd64.tar.gz -C / \
    && rm -rf /tmp/*.tar.gz

# Service directories and the wrapper script
COPY rootfs /

# Run the wrapper script first
ENTRYPOINT ["/usr/local/bin/start"]

# Declare ports to expose
EXPOSE 8080 9527 45566

# Declare volumes
VOLUME ["/rtorrent", "/var/log"]


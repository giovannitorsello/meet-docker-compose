FROM meet_base:latest as builder

WORKDIR /

RUN \
    apt-get update && \
    apt-get install -y jitsi-videobridge2 

COPY rootfs/ /

VOLUME /config

ENTRYPOINT ["/init"]

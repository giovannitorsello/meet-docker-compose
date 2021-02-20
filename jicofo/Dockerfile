FROM meet_base:latest as builder

WORKDIR /

RUN \
	apt-get update && \
	apt-get install -y jicofo

COPY rootfs/ /

VOLUME /config


ENTRYPOINT ["/init"]
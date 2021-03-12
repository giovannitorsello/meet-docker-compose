FROM meet_base:latest as builder

WORKDIR /

RUN apt-get update
RUN apt-get install -y jitsi-videobridge2 
#RUN wget https://download.jitsi.org/stable/jitsi-videobridge2_2.1-416-g2f43d1b4-1_all.deb
#RUN apt-get install uuid-runtime
#RUN dpkg -i jitsi-videobridge2_2.1-416-g2f43d1b4-1_all.deb

COPY rootfs/ /

VOLUME /config

ENTRYPOINT ["/init"]

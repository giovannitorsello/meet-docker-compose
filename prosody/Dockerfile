FROM meet_base:latest as builder


WORKDIR /

#Install prosody to create user, group folder
RUN apt-get install -y prosody python3.5 python3-pip

RUN pip3 install setuptools 
RUN pip3 install wheel 
RUN pip3 install tpl

#Install all prosody module form repository
RUN hg clone https://hg.prosody.im/prosody-modules/ prosody-modules
RUN mkdir -p /usr/lib/prosody/modules/
RUN cp -Rf /prosody-modules/* /usr/lib/prosody/modules/

#RUN apt-get  -y install  luarocks libexpat-dev liblua5.3-dev
#RUN luarocks install luaexpat
#RUN luarocks install luafilesystem
#RUN luarocks install openssl
#RUN luarocks install luaossl
#RUN luarocks install luatz
#RUN luarocks install basexx
#RUN luarocks install otp

#Install luaExpat 1.3 from source
COPY lualib/luaexpat-1.3.3.tar.gz /tmp/
WORKDIR /tmp
RUN tar xfz luaexpat-1.3.3.tar.gz
WORKDIR /tmp/luaexpat-1.3.3
ENV LUA_SYS_VER=5.2
RUN make && make install

#Install Prosody from source
ADD https://prosody.im/downloads/source/prosody-0.11.7.tar.gz /tmp/
WORKDIR /tmp
RUN tar xzf prosody-0.11.7.tar.gz
WORKDIR /tmp/prosody-0.11.7
RUN ./configure --prefix=/
RUN make
RUN make install

WORKDIR /



RUN apt-get -d install -y jitsi-meet-prosody \
    && dpkg -x /var/cache/apt/archives/jitsi-meet-prosody*.deb /tmp/pkg \
    && mv /tmp/pkg/usr/share/jitsi-meet/prosody-plugins /prosody-plMugins \
    && rm -rf /tmp/pkg /var/cache/apt

RUN apt-get -d install -y jitsi-meet-tokens \
    && dpkg -x /var/cache/apt/archives/jitsi-meet-tokens*.deb /tmp/pkg \
    && rm -rf /tmp/pkg /var/cache/apt

#RUN patch -d /usr/lib/prosody/modules/muc -p0 < /prosody-plugins/muc_owner_allow_kick.patch

#Copy init script, basic configuration
COPY rootfs/ /

EXPOSE 5222 5347 5280

#Make folder for prosody and set permissions
#RUN groupadd prosody
#RUN useradd prosody -g prosody
RUN mkdir -p /etc/prosody/certs
RUN mkdir -p /var/run/prosody
RUN mkdir -p /var/lib/prosody
RUN mkdir -p /var/log/prosody

RUN chown -Rf prosody.prosody /etc/prosody/certs
RUN chown -Rf prosody.prosody /var/run/prosody
RUN chown -Rf prosody.prosody /var/lib/prosody
RUN chown -Rf prosody.prosody /var/log/prosody

#delete default configuration
RUN rm -Rf /etc/prosody/*

VOLUME ["/config", "/prosody-plugins-custom"]


### TODO Adjust automatic certificate generation ###
#WORKDIR /etc/prosody/certs
#RUN /etc/prosody/certs/generate-prosody-certs.sh

WORKDIR /
ENTRYPOINT ["/init"]

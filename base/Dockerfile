FROM debian
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /

RUN \
    apt-get update  -y    && \
    apt-get upgrade -y    && \
    apt-get install -y wget gpg gnupg apt-transport-https apt-utils ca-certificates build-essential \
    sudo nano wget jq procps curl vim iputils-ping net-tools jq curl iproute2 nmap telnet make git gcc patch \
    libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev \
    gettext-base sed python2.7-minimal libpython2.7-stdlib mime-support letsencrypt cron nginx-extras certbot git
    
#ADD https://github.com/just-containers/s6-overlay/releases/download/v2.1.0.2/s6-overlay-amd64-installer /tmp/
COPY util/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /

RUN \
    echo "deb http://deb.debian.org/debian/ stretch main contrib non-free" > /etc/apt/sources.list.d/stretch.list && \
    echo "deb-src http://deb.debian.org/debian stretch main contrib non-free" >> /etc/apt/sources.list.d/stretch.list  && \
    echo 'APT::Default-Release "buster";' > /etc/apt/apt.conf.d/config  

RUN echo "deb https://packages.prosody.im/debian buster main" > /etc/apt/sources.list.d/prosody.list
RUN wget https://prosody.im/files/prosody-debian-packages.key -O- | sudo apt-key add -


RUN wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -
RUN echo 'deb https://download.jitsi.org stable/' > /etc/apt/sources.list.d/jitsi-stable.list
RUN apt-get update

RUN apt-get install -y nginx dnsmasq

RUN \
    apt-get install -y \
    mercurial \
    openjdk-8-jre-headless \
    lua5.2 \
    liblua5.2-0 \
    liblua5.2-dev \
    libsasl2-dev \
    libssl1.0-dev \
    libexpat-dev \
    luarocks

RUN luarocks install luacrypto \
    && luarocks install lbase64 \
    && luarocks install cyrussasl 1.1.0-1 \
    && luarocks install lua-cjson 2.1.0-1 \
    && luarocks install luajwtjitsi 1.3-7 \
    && luarocks install net-url 0.9-1 \
    && luarocks install luaexpat \
    && luarocks install luafilesystem \
    && luarocks install openssl \
    && luarocks install luaossl \
    && luarocks install luatz \
    && luarocks install basexx \
    && luarocks install otp 

RUN apt-get install -y \
    libidn11-dev \
    libssl-dev \
    libssl1.0.2 \
    sasl2-bin \
    libsasl2-modules-ldap \
    lua-basexx \
    lua-ldap \
    lua-sec 
    
#Python utilities
RUN apt-get install -y\
    python python-pip

RUN pip install pyasn1-modules 
RUN pip install setuptools 
RUN pip install wheel 
RUN pip install tpl 
RUN pip install grep
RUN pip install envtpl

#Copy init script, basic configuration
COPY rootfs/ /

ENTRYPOINT ["/init"]
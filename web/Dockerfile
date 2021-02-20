FROM meet_base:latest as builder

ADD https://dl.eff.org/certbot-auto /usr/local/bin/

COPY rootfs/ /


RUN \
	apt-get update && \
	apt-get install -y  python2.7-minimal libpython2.7-stdlib mime-support letsencrypt cron nginx-extras

WORKDIR /

#Install node and npm
RUN \
	curl -sL https://deb.nodesource.com/setup_14.x | sudo bash - \
	&& apt-get install nodejs 

WORKDIR /var/www/html/

#Install graphic frontend and lib-jitsi-meet
RUN \
	git clone https://github.com/giovannitorsello/custom-jitsi-meet-web.git \
	&& mv ./custom-jitsi-meet-web ./meet \
	&& cd meet \
	&& git clone https://github.com/jitsi/lib-jitsi-meet.git \
	&& cd lib-jitsi-meet \
	&& npm install \
	&& npm run postinstall \
	&& npm link \
	&& cd .. \
	&& npm link lib-jitsi-meet \
	&& npm install \
	&& npm run postinstall \
	&& make \
	&& chown -Rf www-data.www-data /var/www/html

EXPOSE 80 443

VOLUME ["/config"]

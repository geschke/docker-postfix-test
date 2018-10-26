FROM ubuntu:bionic

LABEL name="Postfix"
LABEL version="0.1"
LABEL maintainer="Ralf Geschke <ralf@kuerbis.org>"

LABEL last_changed="2018-10-26"

# necessary to set default timezone Etc/UTC
ENV DEBIAN_FRONTEND noninteractive 

# war noch hinzugefügt: --no-install-recommends 

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get install -y ca-certificates \
    && apt-get install -y locales apt-utils \
    && apt-get install -y man postfix postfix-doc rsyslog \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get install joe less inetutils-ping

#    && rm -rf /var/lib/apt/lists/* 


ENV LANG en_US.utf8


# Install Forego
ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
RUN chmod u+x /usr/local/bin/forego


COPY . /app/
WORKDIR /app/


EXPOSE 25

#CMD ["/usr/lib/postfix/sbin/master","-d"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
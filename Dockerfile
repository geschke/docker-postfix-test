FROM ubuntu:eoan

LABEL name="Postfix"
LABEL version="0.2.0"
LABEL maintainer="Ralf Geschke <ralf@kuerbis.org>"

LABEL last_changed="2019-12-02"

# necessary to set default timezone Etc/UTC
ENV DEBIAN_FRONTEND noninteractive 

# war noch hinzugefügt: --no-install-recommends 

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get install -y ca-certificates \
    && apt-get install -y locales apt-utils \
    && apt-get install -y man \
    && cd /tmp/ && apt -y install postfix \
    #&& wget http://de.archive.ubuntu.com/ubuntu/pool/main/p/postfix/postfix_3.4.5-1_amd64.deb \
    #&& apt -y install /tmp/postfix_3.4.5-1_amd64.deb \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/* 
    #&& rm /tmp/postfix_3.4.5-1_amd64.deb
    
    


ENV LANG en_US.utf8


# Install Forego
#ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
#RUN chmod u+x /usr/local/bin/forego


COPY ./docker-entrypoint.sh /app/
#COPY ./wait-for-it.sh /app/
WORKDIR /app/


EXPOSE 25

#CMD ["/usr/lib/postfix/sbin/master","-d"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
#CMD ["forego", "start", "-r"]
CMD ["postfix", "start-fg"]


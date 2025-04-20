FROM ubuntu:noble-20250404

LABEL name="Postfix"
LABEL version="0.3.0"
LABEL maintainer="Ralf Geschke <ralf@kuerbis.org>"

LABEL last_changed="2025-04-20"

# necessary to set default timezone Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive 

# war noch hinzugefügt: --no-install-recommends 

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get install -y ca-certificates \
    && apt-get install -y locales apt-utils \
    && apt-get install -y man \
    && cd /tmp/ && apt -y install postfix \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/* 
    

ENV LANG=en_US.utf8

COPY ./docker-entrypoint.sh /app/
#COPY ./wait-for-it.sh /app/
WORKDIR /app/


EXPOSE 25

#CMD ["/usr/lib/postfix/sbin/master","-d"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
#CMD ["forego", "start", "-r"]
CMD ["postfix", "start-fg"]


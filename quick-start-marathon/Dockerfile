FROM magneticio/vamp-clique-zookeeper-marathon:VAMP_VERSION

RUN mkdir -p /usr/local/vamp/conf

VOLUME /usr/local/vamp/conf

ADD start.sh /usr/local/vamp/start
ADD vamp.jar conf /usr/local/vamp/

ADD supervisord.conf /etc/supervisor/supervisord.conf
CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

FROM magneticio/vamp-clique-consul:VAMP_VERSION

RUN mkdir -p /usr/local/vamp

ADD start.sh /usr/local/vamp/start
ADD vamp.jar conf /usr/local/vamp/

ADD supervisord.conf /etc/supervisor/supervisord.conf
CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

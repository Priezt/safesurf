FROM django:1.10

RUN apt-get -yqq update && apt-get -yqq install mysql-client

RUN mkdir -p /root/.pip
COPY pip.conf /root/.pip/pip.conf
RUN pip install gunicorn==19.9.0
RUN pip install requests==2.21.0
RUN pip install PyYAML==5.1

EXPOSE 8000

VOLUME ["/web"]

WORKDIR /web


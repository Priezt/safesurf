FROM ubuntu:16.04

COPY sources.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y x11vnc
RUN apt-get install -y xvfb
RUN apt-get install -y chromium-browser
RUN apt-get install -y xfonts-intl-chinese
RUN apt-get install -y xfonts-wqy
RUN apt-get install -y wget
RUN apt-get install -y net-tools
RUN apt-get install -y vim
#RUN apt-get install -y pulseaudio
RUN apt-get install -y dbus-x11
RUN apt-get install -y fonts-arphic-uming
RUN apt-get install -y fonts-arphic-ukai
RUN apt-get install -y fonts-wqy-microhei
RUN apt-get install -y fonts-wqy-zenhei
RUN apt-get install -y sudo
#RUN apt-get install -y xserver-xorg-video-dummy

#RUN echo "load-module module-native-protocol-tcp auth-anonymous=1" >> /etc/pulse/default.pa

ENV HOME /

RUN mkdir /.vnc
RUN x11vnc -storepasswd 1234 /.vnc/passwd
RUN bash -c 'echo "/start-browser.sh" >> /.bashrc'

EXPOSE 5900
#EXPOSE 4713

COPY entrypoint.sh /entrypoint.sh
COPY start-browser.sh /start-browser.sh
ENTRYPOINT ["/entrypoint.sh"]


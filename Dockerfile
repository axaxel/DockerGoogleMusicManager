# dockergui
FROM phusion/baseimage:0.9.16
MAINTAINER Carlos Hernandez <carlos@techbyte.ca>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" TERM="xterm"


# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
COPY ./files/ /tmp/
RUN chmod +x /tmp/install/install.sh && /tmp/install/install.sh && rm -r /tmp/install

RUN apt-get -y update
RUN apt-get install -y wget

RUN echo "deb http://dl.google.com/linux/musicmanager/deb/ stable main" >> /etc/apt/sources.list.d/google-musicmanager.list
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN apt-get -y update
RUN apt-get install -y google-musicmanager-beta

RUN mkdir /music
VOLUME /music

RUN mkdir -p /appdata /.config /root/.config
RUN ln -s /appdata /.config/google-musicmanager
RUN ln -s /appdata /root/.config/google-musicmanager
VOLUME /appdata

ADD google-musicmanager.sh /google-musicmanager.sh

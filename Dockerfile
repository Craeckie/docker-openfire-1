#name of container: docker-openfire
#versison of container: 0.2.1
FROM quantumobject/docker-baseimage:15.10
MAINTAINER Josia Roßkopf "josia-internet@rosskopfs.de"

# Uses baseimage-docker's init system. (already set in base image)
#CMD ["/sbin/my_init"]

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN apt-get update && apt-get dist-upgrade -y \
                    && apt-get install -y -q openjdk-7-jre \
                    && apt-get clean \
                    && apt-get autoremove -y \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*
                    
ENV CONFIG_BU /root/etc-openfire

# Installs openfire and sparkweb
COPY install.sh /root/install
RUN /bin/bash /root/install \
    && rm /root/install

# Initializes the installation on first run
RUN mkdir -p /etc/my_init.d
COPY init.sh /etc/my_init.d/init.sh
RUN chmod +x /etc/my_init.d/init.sh

# Starts openfire when container is started
RUN mkdir /etc/service/openfire
COPY openfire.sh /etc/service/openfire/run
RUN chmod +x /etc/service/openfire/run 


# Contains the configuration, e.g. Mysql host, credentials, ..
VOLUME /etc/openfire

# Ports to access the server, not all of them needed in all cases
EXPOSE 7070 7443 7777 9090 9091 5000-6000/udp 5000-6000/tcp

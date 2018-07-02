FROM ubuntu:17.10
MAINTAINER Tim Chaubet "tim@chaubet.be"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update 
RUN apt-get dist-upgrade -y 
RUN apt-get install -y net-tools \
                       vim \
                       iputils-ping \
                       libdbus-1-dev \
 && apt-get autoremove -y \
 && apt-get autoclean -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* 

ENTRYPOINT ["tail", "-f", "/dev/null"]
CMD ["bash"]

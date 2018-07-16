FROM ubuntu:17.10
MAINTAINER Tim Chaubet "tim@chaubet.be"

RUN mkdir /run/sshd

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y net-tools \
                       vim \
                       iputils-ping \
                       libdbus-1-dev \
                       libglib2.0-dev \
                       libx11-dev \
                       libgtk2.0-dev \
                       libqt5pas-dev \
                       openssh-server \
                       xpra \
                       xserver-xephyr \
                       xdm \
                       xvfb \
                       xterm \
                       doublecmd-qt \
                       pwgen \
 && apt-get autoremove -y \
 && apt-get autoclean -y \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* 
 
# used this info from https://github.com/rogaha/docker-desktop/blob/master/Dockerfile 
# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
#RUN ln -s /usr/bin/Xorg /usr/bin/X 2>&1
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config
# Fix PAM login issue with sshd
RUN sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

EXPOSE 22

ADD . /

#ENTRYPOINT ["/usr/sbin/sshd", "-D"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
#CMD ["bash"]
CMD ["/bin/bash", "/startup.sh"]

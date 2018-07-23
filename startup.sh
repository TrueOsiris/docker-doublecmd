#!/bin/bash

# Create the directory needed to run the sshd daemon
mkdir /var/run/sshd 

# Add docker user and generate a random password with 12 characters that includes at least one capital letter and number.
if [ -z "$DOCKER_PASSWORD" ]; then
  DOCKER_PASSWORD=`pwgen -c -n -1 12`
fi
echo User: docker Password: $DOCKER_PASSWORD
DOCKER_ENCRYPYTED_PASSWORD=`perl -e 'print crypt('"$DOCKER_PASSWORD"', "aa"),"\n"'`
useradd -m -d /home/docker -p $DOCKER_ENCRYPYTED_PASSWORD docker
sed -Ei 's/adm:x:4:/docker:x:4:docker/' /etc/group
adduser docker sudo

# Set the default shell as bash for docker user.
chsh -s /bin/bash docker

# restarts the xdm service
/etc/init.d/xdm restart

# export the display settings
export DISPLAY=$DISPLAY
DISPLAY=$DISPLAY

# home dir + config
mkdir -p /home/docker/.config/doublecmd
FILE=/home/docker/.config/doublecmd/doublecmd.xml
if [ -f $FILE ]; then
  chmod 777 $FILE   
else
  cp /usr/lib/doublecmd/doublecmd.xml $FILE
  chmod 777 $FILE   
fi

# Start the ssh service
/usr/sbin/sshd -D

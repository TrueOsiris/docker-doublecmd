# docker-doublecmd
Container for https://github.com/doublecmd/doublecmd

- Create the container on the macvlan network (br0, for example) with a LAN IP of choice.
- if you don't specify a password, there is one generated for you, which you can read from the container log.

```
    docker run -d \
    --name='doublecmd' \
    --net='br0' \
    --ip='10.10.71.2' \
    -e TZ="Europe/Paris" \
    -e HOST_OS="unRAID" \
    -e 'TCP_PORT_22'='3322' \
    -e 'DISPLAY'='10.10.32.1:0.0' \
    -e 'DOCKER_PASSWORD'='doublecommander' \
    -v '/tmp/.X11-unix':'/tmp/.X11-unix':'rw' \
    --env="QT_X11_NO_MITSHM=1" 
    'trueosiris/doublecmd'
```

- In windows, install XMing
- Use a .bat file to lauch doublecommander with the following entries.
```
    "C:\Program Files (x86)\Xming\Xming.exe" :0 -clipboard -multiwindow -ac
    plink -ssh docker@CONTAINERIP -pw doublecommander -X -P 22 doublecmd
```

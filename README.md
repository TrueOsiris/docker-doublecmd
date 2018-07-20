# docker-doublecmd
Container for https://github.com/doublecmd/doublecmd

- Create the container on the macvlan network (br0, for example) with a LAN IP of choice.
- if you don't specify a password, there is one generated for you, which you can read from the container log.

```
    docker run -d \
    --name='doublecmd' \
    --net='br0' \
    --ip='10.10.71.2' \
    -e 'DISPLAY'='1.2.3.4:0.0' \
    -e 'DOCKER_PASSWORD'='doublecommander' \
    -v '/tmp/.X11-unix':'/tmp/.X11-unix':'rw' \
    --env="QT_X11_NO_MITSHM=1" 
    'trueosiris/doublecmd'
```

- In windows, install XMing and putty+plink (I actually use kitty instead of putty)
- In putty, make sure you enable X11 forwarding for the Connection -> SSH -> X11
  The X display location should be "1.2.3.4:0.0" where 1.2.3.4 is the lan-ip of the windowsclient you want to use doublecmd on.
- Use a .bat file to lauch doublecommander with the following entries.
```
    "C:\Program Files (x86)\Xming\Xming.exe" :0 -clipboard -multiwindow -ac
    plink -ssh docker@10.10.71.2 -pw doublecommander -X -P 22 "export DISPLAY==1.2.3.4:0.0; DISPLAY=1.2.3.4:0.0; doublecmd"
```

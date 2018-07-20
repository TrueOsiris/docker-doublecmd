# docker-doublecmd
Container for https://github.com/doublecmd/doublecmd

- Create the container on the macvlan network (br0, for example) with a LAN IP of choice.
- 
- In windows, install XMing

- Use a .bat file to lauch doublecommander with the following entries.

"C:\Program Files (x86)\Xming\Xming.exe" :0 -clipboard -multiwindow -ac
plink -ssh docker@CONTAINERIP -pw  -X -P 22 doublecmd

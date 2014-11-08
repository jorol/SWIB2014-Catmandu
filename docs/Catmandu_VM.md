# Catmandu VM

## User

**USR:PWD**

root:catmandu

catmandu:catmandu

## SSH from HOST to GUEST

The best way to login to a guest Linux VirtualBox VM is port forwarding. By default, you should have one interface already which is using NAT. Then go to the Network settings and click the Port Forwarding button. Add a new Rule:

    host port: 3022
    guest port: 22
    name: ssh
    other fields left blank

SSH from host to guest:

```terminal
    ssh -p 3022 catmandu@127.0.0.1
```

## Copy files from HOST to GUEST

Copy files from host to guest:

```terminal
    scp -P 3022 -r ./Basel2014-Catmandu catmandu@127.0.0.1:/home/catmandu
```

## Set keyboard layout

```terminal
# root
$ su
# change layout
$ dpkg-reconfigure keyboard-configuration
# restart
$ shutdown -r 0 
```
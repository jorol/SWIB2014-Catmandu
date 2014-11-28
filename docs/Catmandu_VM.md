# Catmandu VM

## Software requirements

* Download and install VirtualBox <https://www.virtualbox.org/wiki/Downloads>

Windows user only:

* Download and install a ssh client (e.g. Putty <http://www.chiark.greenend.org.uk/~sgtatham/putty/>)
* Download and install a scp client (e.g. WinSCP <http://winscp.net/eng/docs/lang:de>)
* Download and install a text editor (e.g. Notepad++ <http://notepad-plus-plus.org/>)

## VM

* Download a virtual machine image (ask the organisers for login details): 
    - _minimal_ version <http://jorol.de/catmandu/catmandu_cli.ova>
    - _GUI_ version <http://jorol.de/catmandu/catmandu_gui.ova>
* Import the virtual machine in VirtualBox (see <https://docs.oracle.com/cd/E26217_01/E26796/html/qs-import-vm.html>)
* Start the virtual machine (and connect via ssh). 
  If starting fails with error message "implementation of the USB 2.0 controller not found!",
  disable USB support in VirtualBox setting of the imported virtual machine. Ignore the error 
  message "the shared folder '/vagrant' could not be set up".
* Copy the workshop files into virtual machine
  
### User

* _minimal_ VM:
    - User: catmandu
    - Password: catmandu

### SSH from HOST to GUEST 

#### _minimal_ VM:

The best way to login to a guest Linux VirtualBox VM is port forwarding. By default, you should have one interface already which is using NAT. Then go to the Network settings of VM settings and click the Port Forwarding button. Add a new rule, unless ssh is already configured:

    host port: 3022
    guest port: 22
    name: ssh
    other fields left blank

SSH from host to guest with username and password "catmandu":

```terminal
    ssh -p 3022 catmandu@127.0.0.1
```

### Copy files from HOST to GUEST

#### _minimal_ VM:

Copy files from host to guest:

```terminal
    scp -P 3022 -r ./SWIB2014-Catmandu catmandu@127.0.0.1:/home/catmandu
```

Or get workshop files via network with git:

```terminal
git clone https://github.com/jorol/SWIB2014-Catmandu.git
cd SWIB-2014-Catmandu
```

### Set keyboard layout

#### _minimal_ VM:

```terminal
# root
$ su
# change layout
$ dpkg-reconfigure keyboard-configuration
# restart
$ shutdown -r 0 
```

#### _GUI_ VM:

Go to __'System -> Preferences -> Keyboard'__. Tab __'Layouts'__, __'Add...'__ your keyboard layout and mark it as __'Default'__.



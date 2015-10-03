#Bluebird ubuntu config


##Set up commands
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install aptitude
sudo apt-get install build-essential
```

##Fix graphics card bug (causes black screen on startup)
The big problem is trying to use Intel HD graphics with Nvidia. To fix it select Nvidia binary driver (proprietary, tested) and run the following commands:
```
sudo apt-get purge nvidia*
sudo apt-get purge bumblebee*
sudo apt-get -y update
sudo apt-get install nvidia-prime
```

##Fix unknown monitor bug (mouse flickering bug)
Run command `xrandr`. Example output:
```
Screen 0: minimum 320 x 200, current 1366 x 768, maximum 32767 x 32767
LVDS1 connected primary 1366x768+0+0 (normal left inverted right x axis y axis) 344mm x 194mm
   1366x768       60.0*+   60.1  
   1360x768       59.8     60.0  
   1024x768       60.0  
   800x600        60.3     56.2  
   640x480        59.9  
VGA1 disconnected (normal left inverted right x axis y axis)
HDMI1 disconnected (normal left inverted right x axis y axis)
DP1 disconnected (normal left inverted right x axis y axis)
VIRTUAL1 disconnected (normal left inverted right x axis y axis)
VGA-2 connected (normal left inverted right x axis y axis)
   1024x768       60.0  
   800x600        60.3     56.2  
   848x480        60.0  
   640x480        59.9  
  1024x768 (0x43)   65.0MHz
        h: width  1024 start 1048 end 1184 total 1344 skew    0 clock   48.4KHz
        v: height  768 start  771 end  777 total  806           clock   60.0Hz
  800x600 (0x44)   40.0MHz
        h: width   800 start  840 end  968 total 1056 skew    0 clock   37.9KHz
        v: height  600 start  601 end  605 total  628           clock   60.3Hz
  800x600 (0x45)   36.0MHz
        h: width   800 start  824 end  896 total 1024 skew    0 clock   35.2KHz
        v: height  600 start  601 end  603 total  625           clock   56.2Hz
```


LVDS1 is the build in monitor and should be connected the other VGA displays should be disconnected and causes the mouse flickering bug.
Find which one is causing the disturbance (in this case `VGA-2`) and run:

`sudo vim /etc/default/grub`

and replace line:

`GRUB_CMDLINE_LINUX=""`

by

`GRUB_CMDLINE_LINUX="video=VGA-2:d"`

Run `sudo update-grub`

and reboot

##Fix hibernation on laptop

Run command `sudo pm-hibernate` to test if hibernation works.
`sudo -i` To run in root
`cd /var/lib/polkit-1/localauthority/50-local.d/` and create file:
`gedit com.ubuntu.enable-hibernate.pkla`

Paste in the following:

`[Re-enable hibernate by default in upower]
Identity=unix-user:*
Action=org.freedesktop.upower.hibernate
ResultActive=yes

[Re-enable hibernate by default in logind]
Identity=unix-user:*
Action=org.freedesktop.login1.hibernate
ResultActive=yes`

Reboot to enable
##Setup hibernation when closing lid
`sudo vim /etc/systemd/logind.conf`

Change line `#HandleLidSwitch=suspend` to `HandleLidSwitch=hibernate`

Reboot or run `sudo restart systemd-logind` to enable


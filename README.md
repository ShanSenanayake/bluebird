#Bluebird ubuntu config


##Set up commands

`sudo apt-get update`
`sudo apt-get upgrade`
`sudo apt-get install aptitude`
`sudo apt-get install build-essential`


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


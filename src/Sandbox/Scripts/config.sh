#!/bin/sh

set -e
set -u



echo 'DISPLAYS="root:1"' >> /etc/conf.d/tigervnc
echo 'DISPLAYS="root:1"' >> /etc/conf.d/vncserver

echo '{:1=root}' > /etc/tigervnc/vncserver.users


cat <<EOF >> /etc/tigervnc/vncserver-config-defaults
session=xfce
securitytypes=none
geometry=1080x720
localhost=no
alwaysshared
EOF

cat <<EOF >> /etc/tigervnc/vncserver-config-mandatory
session=xfce
securitytypes=none
geometry=1080x720
localhost=no
alwaysshared
EOF


mkdir -p /etc/X11/xorg.conf.d


cat <<EOF >> /etc/X11/xorg.conf.d/40-vnc.conf
Section "Module"
	Load "vnc"
EndSection
Section "Screen"
	Identifier "Default Screen"
	Option "PasswordFile" "/etc/X11/vncpasswd"
EndSection
EOF

printf "vncpassword\nvncpassword\n\n" | vncpasswd /etc/X11/vncpasswd

rm -rfv /tmp/.X*-lock /tmp/.X11-unix
curl -sL "https://raw.githubusercontent.com/iPublications/nodum-raspi/master/setup.sh" > /home/pi/setup.sh
chmod +x /home/pi/setup.sh
echo "@lxterminal -e /home/pi/setup.sh" > /home/pi/.config/lxsession/LXDE-pi/autostart
sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
sed -i "s/1000:1000/0:0/g" /etc/passwd
raspi-config --expand-rootfs
reboot

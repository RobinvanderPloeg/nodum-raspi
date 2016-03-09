sudo curl -sL "https://raw.githubusercontent.com/iPublications/nodum-raspi/master/setup.sh" > /home/pi/setup.sh
sudo chmod +x /home/pi/setup.sh
sudo echo "@sudo lxterminal --geometry=120x30 -e /home/pi/setup.sh" >> /home/pi/.config/lxsession/LXDE-pi/autostart
sudo sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
sudo sed -i "s/1000:1000/0:0/g" /etc/passwd
sudo raspi-config --expand-rootfs
sudo reboot

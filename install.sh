sudo curl -sL "https://raw.githubusercontent.com/RobinvanderPloeg/nodum-raspi/master/setup.sh" > /home/pi/setup.sh
sudo chmod +x /home/pi/setup.sh
sudo echo "@sudo lxterminal --geometry=120x30 -e /home/pi/setup.sh" >> /home/pi/.config/lxsession/LXDE-pi/autostart
sudo sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
sudo sed -i "s/1000:1000/0:0/g" /etc/passwd
echo "# disable ipv6" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo '@xset s off' >> /home/pi/.config/lxsession/LXDE-pi/autostart
echo '@xset -dpms' >> /home/pi/.config/lxsession/LXDE-pi/autostart
echo '@xset s noblank' >> /home/pi/.config/lxsession/LXDE-pi/autostart
sysctl -a
sudo raspi-config --expand-rootfs
sudo reboot

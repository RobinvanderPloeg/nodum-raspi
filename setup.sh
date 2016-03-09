#!/bin/bash

echo "Installing Nodum Kiosk... Wait a few minutes..."
sleep 25

# Muis en screensaver verbergen, beeld niet overscannen
apt-get -y --assume-yes update
apt-get -y --assume-yes upgrade
apt-get -y --assume-yes install x11-xserver-utils unclutter
echo '@xset s off' >> /home/pi/.config/lxsession/LXDE-pi/autostart
echo '@xset -dpms' >> /home/pi/.config/lxsession/LXDE-pi/autostart
echo '@xset s noblank' >> /home/pi/.config/lxsession/LXDE-pi/autostart
cat /etc/ssh/sshd_config  > /tmp/sshd_config && cat /tmp/sshd_config |sed "s/ 22/ 1988/g" > /etc/ssh/sshd_config
cat /boot/config.txt > /tmp/config.txt && cat /tmp/config.txt |sed "s/.disable_overscan/disable_overscan/g" > /boot/config.txt
echo 'display_rotate=0' >> /boot/config.txt
cat /etc/lightdm/lightdm.conf > /tmp/lightdm.conf && cat /tmp/lightdm.conf |sed "s/.*xserver\-command=.*/xserver-command=X -s 0 dpms/g" > /etc/lightdm/lightdm.conf
sed -i "s/autohide=./autohide=1/g" /home/pi/.config/lxpanel/LXDE-pi/panels/panel
sed -i "s/\$/ quiet logo.nologo/g" /boot/cmdline.txt
# sed -i "s/tty1/null/g" /boot/cmdline.txt
echo "disable_splash=1" >> /boot/config.txt
# echo "avoid_warnings=1" >> /boot/config.txt

# Prullenbak van de desktop af
apt-get -y --assume-yes remove gvfs
apt-get -y --assume-yes autoremove

# Logo op de achtergrond
curl --insecure --silent "https://nodum.io/logo_nodum.png" > /usr/share/raspberrypi-artwork/raspberry-pi-logo.png
curl --insecure --silent "https://nodum.io/logo_nodum.png" > /usr/share/raspberrypi-artwork/raspberry-pi-logo-small.png
curl --insecure --silent "https://nodum-devel.theintegrators.nl/images/nodum/logo.svg" > /usr/share/raspberrypi-artwork/raspberry-pi-logo.svg

# Chrome configureren en opstartscript
mkdir /home/pi/chrome && chmod 777 /home/pi/chrome
touch "/home/pi/chrome/First Run"
echo 'export XAUTHORITY=/home/pi/.Xauthority' > /usr/bin/start-chrome
echo "export DISPLAY=':0'" >> /usr/bin/start-chrome
echo '/usr/bin/start-chrome' >> /usr/bin/start-chrome
echo '/usr/bin/chromium-browser --kiosk --ignore-certificate-errors --user-data-dir=/home/pi/chrome/ --test-type --noerrdialogs --no-message-box --disable-desktop-notifications --allow-running-insecure-content --disk-cache-dir=/home/pi/chrome/ --no-sandbox --disable-restore-session-state "https://kantoor.ipublications.net/prtg/test.php/$(ifconfig|grep eth0|sed "s/.\+HW//g"|cut -d " " -f 2)"' >> /usr/bin/start-chrome
echo "@/usr/bin/start-chrome" >> /home/pi/.config/lxsession/LXDE-pi/autostart
echo "killall chromium-browser" > /usr/bin/stop-chrome
echo "rm -r /home/pi/chrome/Default/*" >> /usr/bin/stop-chrome
chmod +x /usr/bin/stop-chrome
chmod +x /usr/bin/start-chrome

# Chromium installeren
cd /tmp
wget https://launchpad.net/~canonical-chromium-builds/+archive/ubuntu/stage/+build/8883797/+files/chromium-codecs-ffmpeg-extra_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb
wget https://launchpad.net/~canonical-chromium-builds/+archive/ubuntu/stage/+build/8883797/+files/chromium-codecs-ffmpeg_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb
wget https://launchpad.net/~canonical-chromium-builds/+archive/ubuntu/stage/+build/8883797/+files/chromium-browser_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb
dpkg -i chromium-codecs-ffmpeg-extra_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb
dpkg -i chromium-codecs-ffmpeg_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb
dpkg -i chromium-browser_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb

# Nieuwe NodeJS versie installeren
apt-get -y --assume-yes remove nodered nodejs nodejs-legacy npm
cd /tmp
curl -sL https://raw.githubusercontent.com/nodesource/distributions/master/deb/setup_5.x|bash -
apt-get -y --assume-yes install nodejs
npm install -g ws

sed -i "s/\(.*lxterminal.*\)//g" /home/pi/.config/lxsession/LXDE-pi/autostart

clear

echo "Install done... Rebooting..."
rm /home/pi/setup.sh

sleep 4

reboot

#!/bin/bash
echo "Updating..."
# Fix branding
curl --insecure --silent "https://nodum-devel.theintegrators.nl/images/nodum/logo.png" > /usr/share/raspberrypi-artwork/raspberry-pi-logo.png
curl --insecure --silent "https://nodum-devel.theintegrators.nl/images/nodum/logo.png" > /usr/share/raspberrypi-artwork/raspberry-pi-logo-small.png
curl --insecure --silent "https://nodum-devel.theintegrators.nl/images/nodum/logo.svg" > /usr/share/raspberrypi-artwork/raspberry-pi-logo.svg
# Fix eth0 HW Ad
echo 'export XAUTHORITY=/home/pi/.Xauthority' > /usr/bin/start-chrome
echo "export DISPLAY=':0'" >> /usr/bin/start-chrome
echo '/usr/bin/stop-chrome' >> /usr/bin/start-chrome
echo '/usr/bin/chromium-browser --kiosk --ignore-certificate-errors --user-data-dir=/home/pi/chrome/ --test-type --noerrdialogs --no-message-box --disable-desktop-notifications --allow-running-insecure-content --disk-cache-dir=/home/pi/chrome/ --no-sandbox --disable-restore-session-state "https://iot.nodum.io/index.php/$(cat /sys/class/net/eth0/address)"' >> /usr/bin/start-chrome
# Fix bug + eth0 HW Ad
sudo curl -sL "https://raw.githubusercontent.com/iPublications/nodum-raspi/master/rotate.sh" > /usr/bin/rotate.sh

reboot
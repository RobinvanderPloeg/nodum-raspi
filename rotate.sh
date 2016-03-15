#!/bin/bash
rotate=$(curl -sL "https://iot.nodum.io/rotate.php/$(cat /sys/class/net/eth0/address)"|egrep "ROTATE:.\."|cut -d ":" -f 2|cut -d "." -f 1)
n=$(echo -n $rotate|grep "^[0-9]$"|wc -l)
if [[ "$n" -gt "0" ]]; then
  echo "Valid: required: $rotate"
  c=$(cat /boot/config.txt|grep "display_rotate" |sed "s/\(display_rotate=\)\(0\)/\2/g")
  echo "Current:         $c"
  if [[ $rotate == $c ]]; then
    echo "The same. Do nothing."
  else
    echo "Different, set and reboot."
    stop-chrome
    sed -i "s/\(display_rotate=\)\(.\)/\1$rotate/g" /boot/config.txt
    sudo reboot
  fi
else
  echo "Invalid"
fi


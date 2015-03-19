#! /bin/bash

apt-get -y install lsb-release
if [ `lsb_release -i -s` == "Debian" ]; then
  wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
  apt-key add mosquitto-repo.gpg.key
  cd /etc/apt/sources.list.d/
  if [ `lsb_release -c -s` == "wheezy" ]; then
    wget http://repo.mosquitto.org/debian/mosquitto-wheezy.list
  elif [ `lsb_release -c -s` == "jessie" ]; then
    wget http://repo.mosquitto.org/debian/mosquitto-jessie.list
  fi
elif [ `lsb_release -i -s` == "Ubuntu" ]; then
  apt-add-repository ppa:mosquitto-dev/mosquitto-ppa
fi

apt-get update
apt-get -y install mosquitto mosquitto-clients libmosquitto-dev php5-dev
echo "" | pecl install Mosquitto-alpha
echo "extension=mosquitto.so" | tee -a /etc/php5/fpm/php.ini
service php5-fpm restart
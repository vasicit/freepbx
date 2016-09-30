#!/bin/bash
adduser asterisk -M -c "Asterisk User"

cd /usr/src
wget http://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz
wget http://downloads.asterisk.org/pub/telephony/libpri/libpri-current.tar.gz
wget http://soft-switch.org/downloads/spandsp/spandsp-0.0.6.tar.gz
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz
wget -O jansson.tar.gz https://github.com/akheron/jansson/archive/v2.7.tar.gz
wget http://www.pjsip.org/release/2.4/pjproject-2.4.tar.bz2
wait ${!}

cd /usr/src
tar -xjvf pjproject-2.4.tar.bz2
rm -f pjproject-2.4.tar.bz2
cd pjproject-2.4
CFLAGS='-DPJ_HAS_IPV6=1' ./configure --prefix=/usr --enable-shared --disable-sound \
--disable-resample --disable-video --disable-opencore-amr --libdir=/usr/lib64
make dep
make
make install
wait ${!}

cd /usr/src
tar vxfz jansson.tar.gz
rm -f jansson.tar.gz
cd jansson-*
autoreconf -i
./configure --libdir=/usr/lib64
make
make install
wait ${!}

cd /usr/src
tar -xzf spandsp-0.0.6.tar.gz
cd spandsp-0.0.6
./configure --libdir=/usr/lib64
make
make install
wait ${!}

cd /usr/src
tar xvfz asterisk-13-current.tar.gz
rm -f asterisk-13-current.tar.gz
cd asterisk-*
contrib/scripts/install_prereq install
./configure --libdir=/usr/lib64
contrib/scripts/get_mp3_source.sh
wait ${!}
make menuselect.makeopts
wait ${!}
make
make install
make config
ldconfig
wait ${!}

mkdir -p /var/lib/asterisk/sounds
cd /var/lib/asterisk/sounds
wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-wav-current.tar.gz
wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz
tar xvf asterisk-core-sounds-en-wav-current.tar.gz
rm -f asterisk-core-sounds-en-wav-current.tar.gz
tar xfz asterisk-extra-sounds-en-wav-current.tar.gz
rm -f asterisk-extra-sounds-en-wav-current.tar.gz
# Wideband Audio download
wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-en-g722-current.tar.gz
wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-g722-current.tar.gz
tar xfz asterisk-core-sounds-en-g722-current.tar.gz
rm -f asterisk-core-sounds-en-g722-current.tar.gz
tar xfz asterisk-extra-sounds-en-g722-current.tar.gz
rm -f asterisk-extra-sounds-en-g722-current.tar.gz

chown asterisk. /var/run/asterisk
chown -R asterisk. /etc/asterisk
chown -R asterisk. /var/{lib,log,spool}/asterisk
chown -R asterisk. /usr/lib64/asterisk
chown -R asterisk. /var/www/

sed -i 's/\(^upload_max_filesize = \).*/\256M/' /etc/php.ini
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
service httpd restart
wait ${!}

cd /usr/src
wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-13.0-latest.tgz
tar xfz freepbx-13.0-latest.tgz
rm -f freepbx-13.0-latest.tgz
cd freepbx
./start_asterisk start
./install -n
wait ${!}

wget -P /etc/yum.repos.d/ -N http://yum.schmoozecom.net/schmooze-commercial/schmooze-commercial.repo
yum clean all
yum -y install php-5.3-zend-guard-loader sysadmin fail2ban incron ImageMagick
/var/lib/asterisk/bin/freepbx_setting MODULE_REPO http://mirror1.freepbx.org,http://mirror2.freepbx.org

service httpd restart
wait ${!}
fwconsole ma download sysadmin
fwconsole ma install sysadmin
#Author add
fwconsole ma enablerepo extended
fwconsole ma enablerepo commercial
chown -R asterisk:asterisk /var/log/asterisk
chown -R asterisk:asterisk /var/run/asterisk
chown -R asterisk:asterisk /var/lib/asterisk
chown -R asterisk:asterisk /var/log/asterisk/*
chown -R asterisk:asterisk /var/run/asterisk/*
chown -R asterisk:asterisk /var/lib/asterisk/*
fwconsole ma download conferences
fwconsole ma install conferences
fwconsole ma refreshsignatures
wait ${!}

sleep 10
reboot

#/bin/bash

PATH=/sbin:/bin:/usr/bin:/usr/sbin
date >> /var/log/system-update.log
yum -y update >> /var/log/system-update.log
wait ${!}
# shutdown -r now

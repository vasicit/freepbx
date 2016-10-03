# freepbx-install

This is a repository with and installation script for FreePBX 13 on CentOS 6

After git clone go to freepbx directory, chmod +x freebpx-install.sh and run with ./freepbx-install.sh

Upon completion of the script the system will reboot automatically. Upon reboot cron will set the appropriate
file permissions for asterisk.

The freepbx-install.sh script can also be copied and pasted into a stackscript or startup script on your VPS.

These scripts are only successfully tested on CentOS 6 VPS's on GCP, DigitalOcean, VULTR and Linode 
as only CentOS 6 is officially supported by FreePBX and Sangoma for commercial modules. 

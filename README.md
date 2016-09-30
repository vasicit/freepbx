# freepbx-install

This is a 3 part installation script for FreePBX 13 on CentOS 6

After git clone there will be 3 shell scripts in the directory.

freepbx-install-1.sh
freepbx-install-2.sh
freepbx-install-3.sh

Chmod +x all 3 of them and run the first one with ./freepbx-install-1.sh

Upon completion of the first script the system will reboot automatically. 
After reboot log back in, return to the same folder and run the 2nd, then after another reboot run the 3rd.
The system will reboot once again and be ready with a freshly installed FreePBX 13.

This will be eventually combined to one script using chkconfig so it will reboot and resume installation automatically.

These installation scripts are only successfully tested on CentOS 6 VPS's on GCP, DigitalOcean, VULTR and Linode 
as only CentOS 6 is officially supported by FreePBX and Sangoma for commercial modules. 

# Zabbix HP Storage Controller (HP Smart Array)

This template uses all items as ACTIVE items and only bash scripts (as usual). <br>
Of course you need to have hpssacli instaled, please set the {$HPSSACLIBIN} Macro on your template or per Host (my is /usr/sbin/hpssacli).<br>
<br>
You can install hpssacli package on CentOS/RHEL using this repository:
```bash
[spp]
name=Service Pack for ProLiant
baseurl=http://downloads.linux.hpe.com/repo/spp/rhel/7/x86_64/current
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/GPG-KEY-ServicePackforProLiant
```
Tested Only on CentOS7. <br>

##This template includes:
* Adapter LowLevelDiscovery;
 * Adapter Description (ex.: Smart Array P410i in Slot 0 ..)
 * Adapter Firmware Version (trigger if changes);
 * Adapter Hardware Revision
 * Adapter Serial Number (trigger if changes);
 * Adapter Cache Serial Number (trigger if changes);
 * Adapter Status (trigger if <> OK);
 * Adapter Cache Status (trigger if <> OK);
 * Adapter Battery Status (trigger if <> OK);
* Logical Disks LowLevelDiscovery;
 * Logical Disk Size;
 * Logical Disk Status (trigger if <> OK);
* Physical Disks LowLevelDiscovery;
 * Physical Disk Model;
 * Physical Disk Serial Number (trigger if changes);
 * Physical Disk Size;
 * Physical Disk Status (trigger if <> OK);
 * Physical Disk Max Temperature;
 * Physical Disk Current Temperature (trigger if > Max Temperature -2)

## ToDo
* ADD Comments to shell scripts

## INSTALL
* Import the template Template-Linux-HW-HPStorageController.xml file;
* Setup SUDO permissions from zabbixsudo file (on CentOS/RedHat/Fedora you can simply copy the file to /etc/sudoers.d/ or add to an existing one);
* Upload support scripts to /etc/zabbix/scripts;
* Set execution permissions to /etc/zabbix/scripts/*;
* Upload the UserParameter file to /etc/zabbix/zabbix_agentd.d/ (or, where your zabbix user parameters are saved);
* Comment (if you have) this directive on /etc/sudoers: "Defaults    requiretty";

# PS
I always use my zabbix_agentd.conf file with "Include=/etc/zabbix/zabbix_agentd.d/", so I can save all templatename.user.parameters files in there.


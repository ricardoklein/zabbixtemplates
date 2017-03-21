# Zabbix RAID MegaCLI Template

This template uses all items as ACTIVE items and only bash scripts (as usual). <br>
Of course you need to have MegaCLI instaled, please set the {$MEGACLIBIN} Macro on your template or per Host (my is /opt/MegaRAID/MegaCli/MegaCli64).<br>

##This template includes:
* Adapter LowLevelDiscovery;
* Checks for:
 * Adapter BIOS Version (trigger on change);
 * Firmware Package Build;
 * Product Name;
 * Serial Number
 * Number of Total Virtual Drives (trigger on change);
 * Number of Degraded Virtual Drives (trigger if > 0);
 * Number of Physical Disks with Critical status (trigger if > 0);
 * Number of Physical Disks with Failed status (trigger if > 0);

## ToDo
* Check every disk for SMART status and preditive fail status;

## INSTALL
* Import the template Template-Linux-HW-MegaCLI.xml file;
* Setup SUDO permissions from zabbixsudo file (on CentOS/RedHat/Fedora you can simply copy the file to /etc/sudoers.d/);
* Upload support scripts to /etc/zabbix/scripts;
* Set execution permissions to /etc/zabbix/scripts/*;
* Upload the UserParameter file to /etc/zabbix/zabbix_agentd.d/ (or, where your zabbix user parameters are saved);
* Comment (if you have) this directive on /etc/sudoers: "Defaults    requiretty";

# PS
I always use my zabbix_agentd.conf file with "Include=/etc/zabbix/zabbix_agentd.d/", so I can save all templatename.user.parameters files in there.


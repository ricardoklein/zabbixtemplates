# Zabbix Script for Integration with company's branch

This script checks if the NFs exist and have been integrated with the company headquarters.

## Tested with:  
 * Zabbix 3.0 with:
 * Oracle 12c Enterprise
 * Oracle 12c Standard Two

## ToDo
* You name it...

## INSTALL
* Import the Template-Linux-APP-Oracle_uOraPy.xml template file;
* Upload scripts "uorapy" to your /etc/zabbix/scripts folder;

# PS
I always use my zabbix_agentd.conf file with "Include=/etc/zabbix/zabbix_agentd.d/", so I can save all user.parameters files in there.

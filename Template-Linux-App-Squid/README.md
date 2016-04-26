# Zabbix Squid Template

This template uses all items as ACTIVE items. <br>
* Tested on Zabbix 3.x and squid versions:
 * 3.4

##This template includes:
* squidclient mgr:info (metrics)
* Number of Squid Processes running (trigger if < 1)
* Squid Memory Usage

## ToDo
* Add Triggers

## INSTALL
* Import the .xml template file;
* Upload the userparameters file to: /etc/zabbix/zabbix_agentd.d/squid.userparameter (or, where your zabbix user parameters are saved)
* Upload the squid_collector.sh script to /etc/zabbix/scripts/ with exec permissions to zabbix user
* Check if you have "UnsafeUserParameters=1" in your zabbix_agentd.conf

# PS
I always use my zabbix_agentd.conf file with "Include=/etc/zabbix/zabbix_agentd.d/", so I can save all user.parameters files in there.

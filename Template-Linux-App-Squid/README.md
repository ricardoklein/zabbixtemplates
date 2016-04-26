# Zabbix Squid Template

This template uses all items as ACTIVE items. <br>
* Tested on Zabbix 3.x and squid versions:
 * 3.0
 * 3.1
 * 3.4

##This template includes:
* squidclient mgr:info for the params:
 * Service time all HTTP requests
 * Request failure ratio
 * Number of HTTP requests received/sec
 * Number of connected clients
 * Mean object size
 * File descriptors configured
 * File descriptors available (trigger if < 100)
 * CPU usage
 * Cache size on disk
 * Cache size in memory
 * Average HTTP requests per minute
* Number of Squid Processes running (trigger if < 1)
* Squid Memory Usage

## ToDo
* Add more triggers?
* Monitor anything else that can come from squidclient?

## INSTALL
* Import the .xml template file;
* Upload the userparameters file to: /etc/zabbix/zabbix_agentd.d/squid.userparameter (or, where your zabbix user parameters are saved)

# PS
I always use my zabbix_agentd.conf file with "Include=/etc/zabbix/zabbix_agentd.d/", so I can save all user.parameters files in there.

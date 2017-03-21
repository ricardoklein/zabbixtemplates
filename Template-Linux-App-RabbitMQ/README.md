# Zabbix MySQL/MariaDB Template

Based on the zabbix mysql template that comes with zabbix. <br>
This template uses all items as ACTIVE items. <br>
Uses the ".my.cnf" file to setup user/password to access the database because I dont think its secure to send it as item parameter over the web. <br>
* Tested on Zabbix 3.0.0 with:
 * MariaDB 5.5
 * MySQL 5.1 

##This template includes:
* Database names Low Level Discovery with prototype items for:
 * Size of earch database;
 * Number of Tables for each database;
* Number of databases;
* Transactions (insert, update, etc) statistics;
* Total databases size;
* Service status and Uptime;
* MySQL version;
* Check for corrupt tables (mysqlcheck);
* Get MySQL/MariaDB memory and processor usage (needs zabbix 3.x);

## ToDo
* Add LLD for InnoDB data files (maybe?)

## INSTALL
* Import the template_zabbix_linux_app_mysql.xml template file;
* Upload the LowLevelDiscovery script to /etc/zabbix/scripts/mysql_database_lld.sh;
* Set execution permission to the script: chmod 755 /etc/zabbix/scripts/mysql_database_lld.sh;
* Upload the userparameters file to: /etc/zabbix/zabbix_agentd.d/mysql.userparamters (or, where your zabbix user parameters are saved)
* Upload your .my.cnf configuration file to the zabbix user $HOME (here it is /etc/zabbix)

# PS
I always use my zabbix_agentd.conf file with "Include=/etc/zabbix/zabbix_agentd.d/", so I can save all user.parameters files in there.


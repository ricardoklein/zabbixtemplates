# Zabbix MySQL/MariaDB Template

Based on the zabbix mysql template that comes with zabbix. <\br>
This template uses all items as ACTIVE items.
Uses the ".my.cnf" file to setup user/password to access the database because I dont think its secure to send it as item parameter over the web.

##This template includes:
* Database names Low Level Discovery with prototype ítens for:
 * Databases size
 * Databases number of tables
* Transactions (insert, update, etc) statistics
* Total databases size
* Service status
* MySQL version

## ToDo
* Add LLD and check of InnoDB data files

## INSTALL
* Import the template_zabbix_linux_app_mysql.xml template file;
* Upload the LowLevelDiscovery script to /etc/zabbix/scripts/mysql_database_lld.sh;
* Set execution permission to the script: chmod 755 /etc/zabbix/scripts/mysql_database_lld.sh;
* Upload the userparameters file to: /etc/zabbix/zabbix_agentd.conf.d/mysql.userparamters (or, where your zabbix user parameters are saved)
* Upload your .my.cnf configuration file to the zabbix user $HOME (here it is /etc/zabbix)

# OBS
I always use my zabbix_agentd.conf file with "Include=/etc/zabbix/zabbix_agentd.conf.d/", so I can save all user.parameters files in there.


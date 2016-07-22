# Zabbix SNMP Template for Dell iDRAC7/8

Based on a zabbix template I found on github (but lost the repo). If you are the original owner, please tell me and I will reference you. <br>
Does SNMP checks against iDRAC7 and iDRAC8 network interface (maybe you need to enable snmp on your iDRAC). <br>

Most of the items have the trigger disabled, because you dont need you zabbix with all that alerts, if you have only the "Overall System Status Error", then you can dig into latest data and/or connecto to iDRAC to get the info about what is happening.

SHAME ON YOU HP iLo!


## Tested on / need:
* Zabbix 3.0+
* Dell iDRAC7 and iDRAC8

##This template includes:
* SNMP checks for RAID Arrays;
* SNMP checks for disk states;
* SNMP checks for General Hardware errors;
* SNMP checks for PowerSupply states;

## ToDo
* Align the trigger severity with my severity matrix;

## INSTALL
* Import the xml template file;

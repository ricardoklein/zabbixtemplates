# Zabbix SNMP Template for Dell iDRAC7

Based on a zabbix template I found on github (but lost the repo). If you are the original owner, please tell me and I will reference you. <br>
Does SNMP checks against iDRAC7 network interface (maybe you need to enable snmp on your iDRAC).

## Tested on / need:
* Zabbix 3.0.0
* Dell iDRAC7

##This template includes:
* SNMP checks for RAID Arrays;
* SNMP checks for disk states;
* SNMP checks for General Hardware errors;
* SNMP checks for PowerSupply states;

## ToDo
* Need to check a "trigger redundancy" on *"Overall System Rollup Status Error"* and *"Overall System Status Error"*

## INSTALL
* Import the xml template file;

# Zabbix Oracle Database Template

Based on lots of examples from other templates, and the first I did using python instead of pure shellscript. This template uses all items as ACTIVE items. And this is the main reason I built this template, I don't want the zabbix server connecting directly in my databases, and, in some cases you even can't do that.  

## Tested with:  
 * Zabbix 3.0 with:
 * Oracle 12c Enterprise
 * Oracle 12c Standard Two

## This template includes:
 * Low Level discovery of disk groups and tablespaces, with size check;
 * Indexes with status = unusable;
 * ASM Disks with status != online; 
 * Check for invalid objects (with Low Level Discovery for what you want to check based in the config file);

## ToDo
* You name it...

## INSTALL
* Import the Template-Linux-APP-Oracle_uOraPy.xml template file;
* Upload scripts "uorapy" to your /etc/zabbix/scripts folder;
* Install Oracle Instant Client (the -devel and -basic should be enough), or, you can use the libs from your oracle install just creating those symlinks (versions may vary):
```bash
 ln -s $ORACLE_HOME/lib/libclntsh.so.11.1 /usr/lib64/
 ln -s $ORACLE_HOME/lib/libnnz11.so /usr/lib64/
 ln -s $ORACLE_HOME/lib/libocci.so.11.1 /usr/lib64/
 ln -s $ORACLE_HOME/lib/libsqlplus.so /usr/lib64/
```

* Install python-cx_Oracle (you can do that with python-pip, but need to enable the EPEL repo and get the python-pip package, also needs python-devel, gcc, make etc to build the module)
* Upload the userparameters file to: /etc/zabbix/zabbix_agentd.d/uorapy.userparamters (or, where your zabbix user parameters are saved)
* Create the Zabbix user on Oracle, recommended permissions:
```sql
 GRANT SELECT ANY TABLE to ZABBIXUSERNAME;
 GRANT CREATE SESSION to ZABBIXUSERNAME;
 GRANT SELECT ANY DICTIONARY to ZABBIXUSERNAME;
 GRANT UNLIMITED TABLESPACE to ZABBIXUSERNAME;
 GRANT SELECT on SYS.V_$SESSION to ZABBIXUSERNAME;
 GRANT SELECT on SYS.V_$SYSTEM_EVENT to ZABBIXUSERNAME;
 GRANT SELECT on SYS.V_$EVENT_NAME to ZABBIXUSERNAME;
 GRANT SELECT on SYS.GV_$ASM_DISKGROUP to ZABBIXUSERNAME;
 GRANT SELECT on SYS.V_$ASM_DISKGROUP to ZABBIXUSERNAME;
 GRANT SELECT on SYS.GV_$ASM_DISK to ZABBIXUSERNAME;
 GRANT SELECT on SYS.V_$ASM_DISK to ZABBIXUSERNAME;
 GRANT SELECT on SYS.V_$RECOVERY_FILE_DEST to ZABBIXUSERNAME;
 GRANT RESOURCE to ZABBIXUSERNAME;
 GRANT CONNECT to ZABBIXUSERNAME;
```

# PS
I always use my zabbix_agentd.conf file with "Include=/etc/zabbix/zabbix_agentd.d/", so I can save all user.parameters files in there.


# Examples:
![alt text](https://github.com/kleinstuff/zabbixtemplates/blob/master/Template-Linux-App-Oracle/images/uorapy_example_01.png "Example 01")

![alt text](https://github.com/kleinstuff/zabbixtemplates/blob/master/Template-Linux-App-Oracle/images/uorapy_example_02.png "Example 02")

![alt text](https://github.com/kleinstuff/zabbixtemplates/blob/master/Template-Linux-App-Oracle/images/uorapy_example_03.png "Example 03")

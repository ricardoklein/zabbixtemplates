# Template-Linux-APP-Openfire

Simple Template to monitor OpenFire service.
You should run openfire as a normal user, not as root (using user openfire here as an example).
This template has macros to set the user and ports openfire is using.


Items:
 - Total number of processes running under user {$OPENFIREUSER}, trigger if number of processes is <1;
 - Total memory used by user ${OPENFIREUSER}, is not that usefull as zabbix does'nt show VmRSS (hope in 3.0+ they will let you choose wich memory value to use);
 - TCP Listening on port {$OPENFIREADMINPORT} (usually 9090), trigger if not listening;
 - TCP Listening on port {$OPENFIREXMPPPORT} (usually 5222), trigger if not listening;

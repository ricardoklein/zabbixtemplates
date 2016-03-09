# Template-Linux-APP-Openfire

* Simple Template to monitor OpenFire service.
* You should run openfire as a normal user, not as root (using user openfire here as an example).
* This template has macros to set the user and ports openfire is using.
* Works on Zabbix 3+ only.


## Items:
* Total number of processes running under user {$OPENFIREUSER}, trigger if number of processes is <1;
* TCP Listening on port {$OPENFIREADMINPORT} (usually 9090), trigger if not listening;
* TCP Listening on port {$OPENFIREXMPPPORT} (usually 5222), trigger if not listening;
* Memory (VmRSS) usage for user ${OPENFIREUSER} (Needs Zabbix3);
* Processor usage for user ${OPENFIREUSER};

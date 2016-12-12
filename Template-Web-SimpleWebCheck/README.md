# Zabbix SimpleWebCheck Template

This template makes simple web checks to a url and has a trigger to alert problems. <br>

##This template includes:
* 2 UserParameters for simple configuration (you should set this for every host):
 * {$WEBCHECK_REQSTRING} = some string that should be returned when the site is OK;
 * {$WEBCHECK_WEBSITEURL} = the url for the website to check ex.: http://foo.bar;
* Timeout of 20s, so, if the website does not open in 20s = error (you can lower this);
* Trigger that alerts if the last 2 checks had problems;

## ToDo
* You can request...

## INSTALL
* Just import the template_SimpleWebCheck.xml template file;


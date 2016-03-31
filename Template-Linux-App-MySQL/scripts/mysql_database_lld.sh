#!/bin/bash

database_lld () {
        COUNTER=1
        echo -ne "{\n    \"data\":[\n"
        DATABASES=$(HOME=/etc/zabbix mysql --batch --skip-column-names -e "show databases;" | grep -v "^mysql$" | grep -v "^information_schema$" | grep -v "^test$" | grep -v "^performance_schema$")
        for DATABASE in $DATABASES
        do
                if [ $COUNTER -ne 1 ]
                then
                        echo -ne ",\n"
                fi
                echo -ne "    {\n            \"{#DATABASENAME}\": \"$DATABASE\"\n    }"
                COUNTER=$(($COUNTER + 1))
        done
        echo -ne "\n]\n}\n"
}


database_lld

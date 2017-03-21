#!/bin/bash


lld_option="$1"

f_getVirtualHosts () {
        COUNTER=1
        echo -ne "{\n    \"data\":[\n"
        VIRTUALHOSTS=$(rabbitmqctl list_vhosts | grep -v "Listing vhosts ...")
        for VHOST in $VIRTUALHOSTS
        do
                if [ $COUNTER -ne 1 ]
                then
                        echo -ne ",\n"
                fi
                echo -ne "    {\n            \"{#VHOSTNAME}\": \"$VHOST\"\n    }"
                COUNTER=$(($COUNTER + 1))
        done
        echo -ne "\n]\n}\n"
}

f_getQueues () {
        COUNTER=1
        echo -ne "{\n    \"data\":[\n"
        VIRTUALHOSTS=$(rabbitmqctl list_vhosts | grep -v "Listing vhosts ...")
        for VHOST in $VIRTUALHOSTS
        do
                for QUEUE in $(rabbitmqctl list_queues -p $VHOST | grep -v "Listing queues ..." | awk {'print $1'})
                do
                    if [ $COUNTER -ne 1 ]
                    then
                            echo -ne ",\n"
                    fi
                    echo -ne "    {\n            \"{#VHOSTNAME}\": \"$VHOST\",\n"
                    echo -ne "            \"{#QUEUE}\": \"$QUEUE\"\n    }"
                    COUNTER=$(($COUNTER + 1))
                done
        done
        echo -ne "\n]\n}\n"
}

case $lld_option in
    virtualhosts)
        f_getVirtualHosts
        ;;
    queues)
        f_getQueues
        ;;
esac

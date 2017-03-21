#!/bin/bash

f_check_average_rtt() {
    echo -ne $(ping -n -c 10 $1 | grep rtt | cut -d"/" -f 5 )
}

f_check_lost_icmp_percent() { 
    local PACKETS=$1
    local INTERVAL=$2
    local TIMEOUT=$3
    local TARGET=$4
    echo -ne "$(ping -c $PACKETS -i $INTERVAL -W $TIMEOUT $TARGET | grep 'packets' | cut -d' ' -f6 | tr -d '%')"
}

f_targets_auto_discovery() {
        COUNTER=1
        echo -ne "{\n    \"data\":[\n"
        TARGETS=$1
        for TARGET in $TARGETS
        do
                if [ $COUNTER -ne 1 ]
                then
                        echo -ne ",\n"
                fi
                echo -ne "    {\n            \"{#TARGETIP}\": \"$TARGET\"\n    }"
                COUNTER=$(($COUNTER + 1))
        done
        echo -ne "\n]\n}\n"
       
}



#f_check_average_rtt "4.2.2.2"
echo ""
#f_check_lost_icmp_percent 5 2 4 "4.2.2.0"
echo ""
f_targets_auto_discovery "4.2.2.2 8.8.8.8 8.8.8.1"


#!/bin/bash



MegaClIBin="$1"
AdaptersList=$(sudo $MegaClIBin -AdpAllInfo -aALL -nolog | grep Adapter | grep -v "Supported" | cut -f2 -d" " | cut -f2 -d#)

ListAdapters() {
	COUNTER=1
	echo -ne "{\n    \"data\":[\n"
	for AdapterID in $AdaptersList
	do
		if [ $COUNTER -ne 1 ]
		then
			echo -ne ",\n"
		fi
		echo -ne "    {\n            \"{#ADAPTERID}\": \"$AdapterID\"\n    }"
		COUNTER=$(($COUNTER + 1))
	done
	echo -ne "\n]\n}\n"
}

ListAdapters

#!/bin/bash



#HPSsacli: /usr/sbin/hpssacli

ControllerCliBin="$1"
lld_option="$2"

f_listAdapters() {
	AdaptersList="$(sudo $ControllerCliBin ctrl all show detail | grep Slot: | cut -d: -f2 | tr -d '[[:space:]]')"
	echo "$AdaptersList"
}

f_getControllers() {
	COUNTER=1
	echo -ne "{\n    \"data\":[\n"
	for AdapterID in $(f_listAdapters)
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

f_getLogicalDisks(){
	COUNTER=1
	echo -ne "{\n    \"data\":[\n"

	for AdapterID in $(f_listAdapters)
	do
		LogicalDrives="$(sudo $ControllerCliBin ctrl slot=$AdapterID ld all show status | grep "logicaldrive" | cut -d" " -f5 )"
		for LogicalDrive in $LogicalDrives
		do
			if [ $COUNTER -ne 1 ]
			then
				echo -ne ",\n"
			fi

			echo -ne "\t\t{\n"
			echo -ne "\t\t\t\"{#ADAPTERID}\": \"$AdapterID\",\n"
			echo -ne "\t\t\t\"{#LOGICALDRIVEID}\": \"$LogicalDrive\"\n"
			echo -ne "\t\t}"
			COUNTER=$(($COUNTER + 1))
		done
	done

	echo -ne "\n]\n}\n"
}

f_getPhysicalDisks(){
	COUNTER=1
	echo -ne "{\n    \"data\":[\n"

	for AdapterID in $(f_listAdapters)
	do
		PhysicalDrives="$(sudo $ControllerCliBin ctrl slot=$AdapterID pd all show detail | grep physicaldrive | cut -d" " -f8 )"
		for PhysicalDrive in $PhysicalDrives
		do
			if [ $COUNTER -ne 1 ]
			then
				echo -ne ",\n"
			fi

			echo -ne "\t\t{\n"
			echo -ne "\t\t\t\"{#ADAPTERID}\": \"$AdapterID\",\n"
			echo -ne "\t\t\t\"{#PHYSICALDRIVEID}\": \"$PhysicalDrive\"\n"
			echo -ne "\t\t}"
			COUNTER=$(($COUNTER + 1))
		done
	done

	echo -ne "\n]\n}\n"
}

case $lld_option in
	controllers)
		f_getControllers
	;;
	logicalDisks)
		f_getLogicalDisks
	;;
	physicalDisks)
		f_getPhysicalDisks
	;;

esac

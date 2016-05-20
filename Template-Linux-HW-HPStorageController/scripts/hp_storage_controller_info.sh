#!/bin/bash



#HPSsacli: /usr/sbin/hpssacli

ControllerCliBin="$2"
ControllerSlot="$3"


f_getControllerDescription() {
	echo -ne $(sudo $ControllerCliBin ctrl slot=$ControllerSlot show detail | head -2 | tail -1)
}

f_getControllerSerialNumber() {
	echo -ne $(sudo $ControllerCliBin ctrl slot=$ControllerSlot show detail | grep "Serial Number" | grep -v -e Cache -e Host | cut -d: -f2)
}

f_getControllerCacheSerialNumber() {
	echo -ne $(sudo $ControllerCliBin ctrl slot=$ControllerSlot show detail | grep "Cache Serial Number" | cut -d: -f2)
}

f_getControllerHardwareRevision() {
	echo -ne $(sudo $ControllerCliBin ctrl slot=$ControllerSlot show detail | grep "Hardware Revision" | cut -d: -f2)
}

f_getControllerFirmwareVersion() {
	echo -ne $(sudo $ControllerCliBin ctrl slot=$ControllerSlot show detail | grep "Firmware Version" | cut -d: -f2)
}

f_getControllerStatus() {
	Status=$(sudo $ControllerCliBin ctrl slot=$ControllerSlot show detail | grep "Controller Status" | cut -d: -f2)
	if [ "$Status"=="OK" ]
	then
		echo -ne "0"
	else
		echo -ne "1"
	fi
}

f_getControllerCacheStatus() {
	Status=$(sudo $ControllerCliBin ctrl slot=$ControllerSlot show detail | grep "Cache Status" | cut -d: -f2)
	if [ "$Status"=="OK" ]
	then
		echo -ne "0"
	else
		echo -ne "1"
	fi
}

f_getControllerBatteryStatus() {
	Status=$(sudo $ControllerCliBin ctrl slot=$ControllerSlot show detail | grep "Battery/Capacitor Status" | cut -d: -f2)
	if [ "$Status"=="OK" ]
	then
		echo -ne "0"
	else
		echo -ne "1"
	fi
}

f_getLogicalDiskSize(){
	LogicalDisk=$1
	echo "$(sudo $ControllerCliBin ctrl slot=$ControllerSlot ld $LogicalDisk show detail | grep Size | grep -v Strip | cut -d: -f2 | tr -d "[[:space:]]" | tr -d "GB")*1024*1024*1024" | bc | cut -d. -f1

}

f_getLogicalDiskStatus() {
	LogicalDisk=$1
	Status=$(sudo $ControllerCliBin ctrl slot=$ControllerSlot ld $LogicalDisk show detail | grep Status | grep -v OS | cut -d: -f2 | tr -d "[:space:]" )
	if [ "$Status"=="OK" ]
	then
		echo -ne "0"
	else
		echo -ne "1"
	fi
}

f_getPhysicalDiskStatus() {
	PhysicalDisk=$1
	Status=$(sudo $ControllerCliBin ctrl slot=$ControllerSlot pd $PhysicalDisk show detail | grep Status | cut -d: -f2 | tr -d "[:space:]")
	if [ "$Status"=="OK" ]
	then
		echo -ne "0"
	else
		echo -ne "1"
	fi
}

f_getPhysicalDiskSerialNumber() {
	PhysicalDisk=$1
	echo "$(sudo $ControllerCliBin ctrl slot=$ControllerSlot pd $PhysicalDisk show detail | grep Serial | cut -d: -f2 | tr -d "[:space:]")"
}

f_getPhysicalDiskModel() {
	PhysicalDisk=$1
	echo "$(sudo $ControllerCliBin ctrl slot=$ControllerSlot pd $PhysicalDisk show detail | grep Model | cut -d: -f2 | tr -d "[:space:]")"
}

f_getPhysicalDiskSize() {
	PhysicalDisk=$1
	echo "$(sudo $ControllerCliBin ctrl slot=$ControllerSlot pd $PhysicalDisk show detail | grep Size | grep -v Native | cut -d: -f2 | tr -d "[[:space:]]" | tr -d "TB")*1024*1024*1024*1024" | bc
}

f_getPhysicalDiskCurrentTemperature() {
	PhysicalDisk=$1
	echo "$(sudo $ControllerCliBin ctrl slot=$ControllerSlot pd $PhysicalDisk show detail | grep "Current Temperature" | cut -d: -f2 | tr -d "[:space:]"})"
}

f_getPhysicalDiskMaxTemperature() {
	PhysicalDisk=$1
	echo "$(sudo $ControllerCliBin ctrl slot=$ControllerSlot pd $PhysicalDisk show detail | grep "Maximum Temperature" | cut -d: -f2 | tr -d "[:space:]"})"
}

case $1 in
	ControllerDescription)
		f_getControllerDescription
	;;
	ControllerSerialNumber)
		f_getControllerSerialNumber
	;;
	ControllerCacheSerialNumber)
		f_getControllerCacheSerialNumber
	;;
	ControllerHardwareRevision)
		f_getControllerHardwareRevision
	;;
	ControllerFirmwareVersion)
		f_getControllerFirmwareVersion
	;;
	ControllerStatus)
		f_getControllerStatus
	;;
	ControllerCacheStatus)
		f_getControllerCacheStatus
	;;
	ControllerBatteryStatus)
		f_getControllerBatteryStatus
	;;	
	LogicalDiskSize)
		f_getLogicalDiskSize $4
	;;
	LogicalDiskStatus)
		f_getLogicalDiskStatus $4
	;;
	PhysicalDiskStatus)
		f_getPhysicalDiskStatus $4
	;;
	PhysicalDiskSerialNumber)
		f_getPhysicalDiskSerialNumber $4
	;;
	PhysicalDiskModel)
		f_getPhysicalDiskModel $4
	;;
	PhysicalDiskSize)
		f_getPhysicalDiskSize $4
	;;
	PhysicalDiskCurrentTemperature)
		f_getPhysicalDiskCurrentTemperature $4
	;;
	PhysicalDiskMaxTemperature)
		f_getPhysicalDiskMaxTemperature $4
	;;

esac


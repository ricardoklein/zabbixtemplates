#!/bin/bash

MegaCLIBin="sudo $3"
AdapterID="$2"

f_getProductName() {
	ProductName=$($MegaCLIBin -AdpAllInfo -a$AdapterID -nolog | grep "Product Name" | cut -f2 -d:)
	echo -ne $ProductName
}

f_getSerialNumber() {
	SerialNumber=$($MegaCLIBin -AdpAllInfo -a$AdapterID -nolog | grep "Serial No" | cut -f2 -d:)
	echo -ne $SerialNumber
}

f_getFWPackageBuild() {
	FWPackageBuild=$($MegaCLIBin -AdpAllInfo -a$AdapterID -nolog | grep "FW Package Build" | cut -f2 -d:)
	echo -ne $FWPackageBuild
}

f_getBIOSVersion() {
	BIOSVersion=$($MegaCLIBin -AdpAllInfo -a$AdapterID -nolog | grep "BIOS Version" | cut -f2 -d:)
	echo -ne $BIOSVersion
}

f_getTotalVirtualDrives() {
	TotalVirtualDrives=$($MegaCLIBin -AdpAllInfo -a$AdapterID -nolog | grep "Virtual Drives" | cut -f2 -d:)
	echo -ne $TotalVirtualDrives
}

f_getVirtualDrivesDegraded() {
	VirtualDrivesDegraded=$($MegaCLIBin -AdpAllInfo -a$AdapterID -nolog | grep "Degraded" | cut -f2 -d:)
	echo -ne $VirtualDrivesDegraded
}

f_getCriticalPhysicalDisks() {
	CriticalPhysicalDisks=$($MegaCLIBin -AdpAllInfo -a$AdapterID -nolog | grep "Critical Disks" | cut -f2 -d:)
	echo -ne $CriticalPhysicalDisks
}

f_getFailedPhysicalDisks() {
	FailedPhysicalDisks=$($MegaCLIBin -AdpAllInfo -a$AdapterID -nolog | grep "Failed Disks" | cut -f2 -d:)
	echo -ne $FailedPhysicalDisks
}

case "$1" in
	--ProductName)
		f_getProductName
		;;
	--SerialNumber)
		f_getSerialNumber
		;;
	--FWPackageBuild)
		f_getFWPackageBuild
		;;
	--BIOSVersion)
		f_getBIOSVersion
		;;
	--TotalVirtualDrives)
		f_getTotalVirtualDrives
		;;
	--VirtualDrivesDegraded)
		f_getVirtualDrivesDegraded
		;;
	--OfflineVirtualDrives)
		f_getOfflineVirtualDrives
		;;
	--TotalPhysicalDisks)
		f_getTotalPhysicalDisks
		;;
	--CriticalPhysicalDisks)
		f_getCriticalPhysicalDisks
		;;
	--FailedPhysicalDisks)
		f_getFailedPhysicalDisks
		;;
esac


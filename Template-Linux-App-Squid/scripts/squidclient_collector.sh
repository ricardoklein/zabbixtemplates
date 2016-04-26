#!/bin/bash


SQUIDCLIENTBIN="$1"
SQUIDMETRIC="$2"
ValuePosition="$3"
TempFile="$4"


# Get squid data
(
$SQUIDCLIENTBIN mgr:info | grep "$SQUIDMETRIC" > /tmp/squid-$TempFile
) > /dev/null 2>&1

# Format and print squid data
echo -ne $(cat /tmp/squid-$TempFile) | awk -v position="$ValuePosition" {'printf $position'} | tr -d '%,'

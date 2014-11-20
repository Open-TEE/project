#!/bin/sh

#stop the script if a command fails
set -e

# Sets up opentee.conf and copies it to /etc/opentee.conf
# Needs to be ran as root

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cp opentee.conf tmp.conf

WORK=`pwd`
TA=$WORK/../TAs/
LIB=$WORK/../libtee/

sed -i "s|<PATH TO TAs>|$TA|" tmp.conf
sed -i "s|<PATH TO LIBS>|$LIB|" tmp.conf
cp tmp.conf /etc/opentee.conf
rm tmp.conf

echo "Done"

exit 0

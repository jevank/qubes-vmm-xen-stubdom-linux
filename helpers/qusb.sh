#!/bin/sh

echo -n "$ACTION $MDEV " >> /tmp/qusb.log

if [ "$ACTION" == "bind" ]; then
	SPEED=`sed -n '1p;' /sys/$DEVPATH/speed`
	if [ $SPEED -gt 480 ]; then BUS="xhci.0"; else BUS="ehci.0"; fi;
	echo "$SPEED $BUS $DEVPATH" >> /tmp/qusb.log
	BUSID="busid-$BUS-`busybox basename $MDEV`"
        echo '{ "execute": "device_add", "arguments": { "driver": "usb-host", "id": "'"$BUSID"'", "bus": "'"$BUS"'", "guest-reset": "False" } }' > /tmp/qmp/qemu.in
elif [ "$ACTION" == "unbind" ]; then
	echo "done" >> /tmp/qusb.log
	echo '{ "execute": "device_del", "arguments": { "id": "busid-'"`busybox basename $MDEV`"'" } }' > /tmp/qmp/qemu.in
else
	echo "skip action" >> /tmp/qusb.log
fi

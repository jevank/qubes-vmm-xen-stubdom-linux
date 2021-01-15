#!/bin/sh

if [ "$ACTION" == "bind" ]; then
	SPEED=`sed -n '1p;' /sys/$DEVPATH/speed`
	BUSID="busid-$MAJOR-$MINOR"
        echo '{ "execute": "device_add", "arguments": { "driver": "usb-host", "id": "'"$BUSID"'", "bus": "xhci.0", "guest-reset": "False" } }' > /tmp/qmp/qemu.in
elif [ "$ACTION" == "unbind" ]; then
	echo '{ "execute": "device_del", "arguments": { "id": , "id": "'"$BUSID"'"} }' > /tmp/qmp/qemu.in
else echo; fi


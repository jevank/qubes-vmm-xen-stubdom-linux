#!/bin/sh

if [ "$ACTION" == "bind" ]; then
	SPEED=`sed -n '1p;' /sys/$DEVPATH/speed`
	BUS=""
	if [ $SPEED -gt 480 ]; then BUS='"bus": "xhci.0",'; fi;
	BUSID="busid-$MAJOR-$MINOR"
        echo '{ "execute": "device_add", "arguments": { "driver": "usb-host", "id": "'"$BUSID"'", '$BUS' "guest-reset": "False" } }' > /tmp/qmp/qemu.in
elif [ "$ACTION" == "unbind" ]; then
	echo '{ "execute": "device_del", "arguments": { "id": , "id": "'"$BUSID"'"} }' > /tmp/qmp/qemu.in
else echo; fi


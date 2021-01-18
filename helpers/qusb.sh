#!/bin/sh

BUSID="busid-$MAJOR-$MINOR"
if [ "$ACTION" == "bind" ]; then
        echo '{ "execute": "device_add", "arguments": { "driver": "usb-host", "id": "'"$BUSID"'", "bus": "xhci.0" } }' > /tmp/qmp/qemu.in
elif [ "$ACTION" == "unbind" ]; then
	echo '{ "execute": "device_del", "arguments": { "id": "'"$BUSID"'" } }' > /tmp/qmp/qemu.in
else echo; fi


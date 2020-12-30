#!/bin/sh

echo "$ACTION $MDEV" >> /tmp/qusb.log

if [ "$ACTION" == "bind" ]; then
       echo '{ "execute": "device_add", "arguments": { "driver": "usb-host", "id": "busid-'"`busybox basename $MDEV`"'", "bus": "xhci.0", "guest-reset": "False" } }' > /tmp/qmp/qemu.in
elif [ "$ACTION" == "unbind" ]; then
	echo '{ "execute": "device_del", "arguments": { "id": "busid-'"`busybox basename $MDEV`"'" } }' > /tmp/qmp/qemu.in
else
	echo "skip action" >> /tmp/qusb.log
fi

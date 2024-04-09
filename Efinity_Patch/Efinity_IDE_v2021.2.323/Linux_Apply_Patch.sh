#! /bin/bash

if [  $(id -u) != "0" ] ; then
	echo "Please run as root!"
	exit 1
fi

read -p 'Efinity install directory (contains pgm directory): ' TARGET_FOLDER

if ! test -f "${TARGET_FOLDER}/pgm/bin/efx_pgm/usb_resolver.py"; then
	echo "Efinity file does not exist!"
	exit 1
fi

if test -f "${TARGET_FOLDER}/pgm/bin/efx_pgm/usb_resolver.py.orig"; then
	echo "Patch file has already been applied!"
	exit 1
fi

cd "$(dirname "$0")"

cp 99-efinix_download_cable.rules /etc/udev/rules.d/
cp efx_hw_common/boards/* "${TARGET_FOLDER}/pgm/bin/efx_pgm/efx_hw_common/boards/"
patch -b "${TARGET_FOLDER}/pgm/bin/efx_pgm/usb_resolver.py" usb_resolver.py.diff

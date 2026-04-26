#!/system/bin/sh

SCRIPT_NAME="$(basename "$0")"

LOGMSG() {
    echo "I:$@" >> /tmp/recovery.log
}

LOGMSG "---$SCRIPT_NAME start---"

if [ -f /tmp/fox_backup.img ]; then
	for slot in _a _b; do
		LOGMSG "Restoring OrangeFox to slot ${slot}..."
		if dd if="/tmp/fox_backup.img" of="/dev/block/bootdevice/by-name/recovery${slot}" bs=1M; then
			sync
		else
			LOGMSG "Failed to flash to slot ${slot}..."
		fi
	done
else
	LOGMSG "Unable to find OrangeFox image for restoring..."
fi

LOGMSG "---$SCRIPT_NAME end---"

# reboot recovery

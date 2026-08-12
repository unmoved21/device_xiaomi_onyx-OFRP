#!/system/bin/sh

SCRIPT_NAME="$(basename "$0")"

LOGMSG() {
    echo "I:$@" >> /tmp/recovery.log
}

LOGMSG "---$SCRIPT_NAME start---"

LOGMSG "Detecting active boot slot..."
slot="$(getprop ro.boot.slot_suffix)"

if [ -z "$slot" ]; then
    LOGMSG "ERROR: Unable to detect active boot slot"
    exit 1
fi

LOGMSG "Active boot slot: $slot"

RECOVERY="/dev/block/bootdevice/by-name/recovery${slot}"

LOGMSG "Recovery partition: $RECOVERY"

if [ ! -e "$RECOVERY" ]; then
    LOGMSG "ERROR: Recovery partition not found!"
    exit 1
fi

LOGMSG "Backing up recovery.img before ROM overwrites..."

if dd if="$RECOVERY" of="/tmp/fox_backup.img" bs=1M; then
    sync
    LOGMSG "Recovery backup completed successfully"
else
    LOGMSG "ERROR: Failed to backup recovery.img"
    exit 1
fi

LOGMSG "---$SCRIPT_NAME end---"

exit 0

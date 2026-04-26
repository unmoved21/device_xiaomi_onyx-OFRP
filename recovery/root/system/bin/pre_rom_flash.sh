#!/system/bin/sh

SCRIPT_NAME="$(basename "$0")"

LOGMSG() {
    echo "I:$@" >> /tmp/recovery.log
}

LOGMSG "---$SCRIPT_NAME start---"

LOGMSG "Resetting SPL date to prevent anti-rollback protection..."
resetprop ro.build.version.security_patch 2023-12-31

LOGMSG "Detecting active boot slot..."
slot="$(getprop ro.boot.slot_suffix)"
LOGMSG "Active boot slot: $slot"

LOGMSG "Backing up recovery.img before ROM overwrites..."
dd if="/dev/block/bootdevice/by-name/recovery${slot}" of="/tmp/fox_backup.img" bs=1M
sync

LOGMSG "---$SCRIPT_NAME end---"

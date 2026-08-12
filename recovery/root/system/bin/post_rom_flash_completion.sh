#!/system/bin/sh

SCRIPT_NAME="$(basename "$0")"

LOGMSG() {
    echo "I:$@" >> /tmp/recovery.log
}

LOGMSG "---$SCRIPT_NAME start---"

if [ -s /tmp/fox_backup.img ]; then

    for slot in _a _b; do

        RECOVERY="/dev/block/bootdevice/by-name/recovery${slot}"

        if [ -e "$RECOVERY" ]; then
            LOGMSG "Restoring OrangeFox to $RECOVERY..."

            if dd if="/tmp/fox_backup.img" of="$RECOVERY" bs=1M; then
                sync
                LOGMSG "OrangeFox restored successfully to slot ${slot}"
            else
                LOGMSG "ERROR: Failed to restore OrangeFox to slot ${slot}"
            fi
        else
            LOGMSG "Recovery partition not found for slot ${slot}, skipping..."
        fi

    done

else
    LOGMSG "ERROR: Unable to find OrangeFox backup image"
    exit 1
fi

LOGMSG "---$SCRIPT_NAME end---"

exit 0

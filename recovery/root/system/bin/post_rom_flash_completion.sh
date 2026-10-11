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

# Flag is created by the "Install DFE after flashing ROM" checkbox (install.xml)
if [ ! -f /tmp/fox_auto_dfe ]; then
    LOGMSG "Automatic DFE not requested, skipping..."
    LOGMSG "---$SCRIPT_NAME end---"
    exit 0
fi

DFE_ZIP="/FFiles/DFE.zip"

if [ ! -f "$DFE_ZIP" ]; then
    LOGMSG "ERROR: $DFE_ZIP not found, skipping automatic DFE"
    LOGMSG "---$SCRIPT_NAME end---"
    exit 1
fi

LOGMSG "Clearing previous DFE installation logs..."
rm -rf /sdcard/neo_file_*

LOGMSG "Setting instructions for next reboot..."
mkdir -p /cache/recovery
echo "install $DFE_ZIP" > /cache/recovery/openrecoveryscript

LOGMSG "Preserving recovery.log before recovery reboot..."
LOGMSG "---$SCRIPT_NAME end---"
mkdir -p /persist/Fox/logs
cp /tmp/recovery.log "/persist/Fox/logs/dfe_recovery_$(date +"%Y%m%d_%H%M%S").log"

reboot recovery

exit 0

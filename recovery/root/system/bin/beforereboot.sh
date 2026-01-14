#!/system/bin/sh

SCRIPT_NAME="$(basename "$0")"

LOGMSG() {
    echo "I:$*" >> /tmp/recovery.log
}

LOGMSG "---$SCRIPT_NAME start---"

if [ -d /sdcard/Fox ]; then
    LOGMSG "Correcting SELinux context and ownership of Fox folder..."
    chcon -R u:object_r:media_rw_data_file:s0 /sdcard/Fox
    chown -R media_rw:media_rw /sdcard/Fox
fi

LOGMSG "Correcting SELinux context and ownership of recovery-generated logs..."
for f in dmesg.log logcat.log recovery.log; do
    if [ -f "/sdcard/$f" ]; then
        chcon u:object_r:media_rw_data_file:s0 "/sdcard/$f"
        chown media_rw:media_rw "/sdcard/$f"
        LOGMSG "Corrected: /sdcard/$f"
    fi
done

LOGMSG "---$SCRIPT_NAME end---"

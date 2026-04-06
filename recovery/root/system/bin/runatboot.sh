#!/system/bin/sh

DEBUG=0
[ "$DEBUG" = "1" ] && set -o xtrace

LOGMSG() {
    echo "I:$@" >> /tmp/recovery.log
}

reset_touch() {
    LOG=/tmp/touch-revive.log

    tlog() {
        echo "[touch-revive] $*" >> "$LOG"
    }

    tlog "=== reset_touch start ==="

    # node list
    ls -l /sys/devices/virtual/touch/touch_dev >> "$LOG" 2>&1

    # fetch info
    cat /sys/devices/virtual/touch/touch_dev/touch_vendor >> "$LOG" 2>&1
    cat /sys/devices/virtual/touch/touch_dev/panel_vendor >> "$LOG" 2>&1
    cat /sys/devices/virtual/touch/touch_dev/panel_display >> "$LOG" 2>&1

    # increase log level
    if [ -e /sys/devices/virtual/touch/touch_dev/touch_log_level ]; then
        echo 1 > /sys/devices/virtual/touch/touch_dev/touch_log_level 2>>"$LOG"
        tlog "touch_log_level set to 1"
    fi

    # SAFE test: enable raw touch
    if [ -e /sys/devices/virtual/touch/touch_dev/enable_touch_raw ]; then
        tlog "trying enable_touch_raw toggle"
        echo 0 > /sys/devices/virtual/touch/touch_dev/enable_touch_raw 2>>"$LOG"
        sleep 1
        echo 1 > /sys/devices/virtual/touch/touch_dev/enable_touch_raw 2>>"$LOG"
    fi

    tlog "=== reset_touch end ==="
}

SCRIPT_NAME="$(basename "$0")"

LOGMSG "---$SCRIPT_NAME start---"

# important: wait for driver initialization to finish
sleep 10

reset_touch

/sbin/prune_historic_logs.sh 10

LOGMSG "---$SCRIPT_NAME end---"
exit 0

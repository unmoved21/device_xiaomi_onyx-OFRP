#!/system/bin/sh

DEBUG=0
[ "$DEBUG" = "1" ] && set -o xtrace

LOGMSG() {
	echo "I:$@" >> /tmp/recovery.log
}

optimize_io_and_cpu() {
	LOGMSG "Applying I/O optimizations to block devices..."

	# Optimize all physical UFS partitions (sda, sdb, sdc, sdd, sde, sdf)
	for disk in /sys/block/sd*; do
		if [ -d "$disk/queue" ]; then
			dev=$(basename "$disk")
			# 1. Bypass scheduler overhead (direct I/O dispatch)
			if grep -q "none" "$disk/queue/scheduler" 2>/dev/null; then
				echo none > "$disk/queue/scheduler" 2>/dev/null
			fi

			# 2. Increase read-ahead buffer to 2048 KB
			echo 2048 > "$disk/queue/read_ahead_kb" 2>/dev/null

			# 3. Increase block request backlog depth
			echo 512 > "$disk/queue/nr_requests" 2>/dev/null

			# 4. Disable I/O accounting statistics to reduce CPU overhead
			echo 0 > "$disk/queue/iostats" 2>/dev/null

			# 5. Disable rotational delay penalty
			echo 0 > "$disk/queue/rotational" 2>/dev/null

			# 6. Disable add_random overhead (don't contribute disk entropy)
			echo 0 > "$disk/queue/add_random" 2>/dev/null

			LOGMSG "Optimized physical device: $dev"
		fi
	done

	# Optimize dynamic partition mapper and loop devices (dm-*, loop*)
	# nr_requests is not writable on dm devices, so only apply read_ahead and iostats
	for dev in /sys/block/dm-* /sys/block/loop*; do
		if [ -d "$dev/queue" ]; then
			echo 2048 > "$dev/queue/read_ahead_kb" 2>/dev/null
			echo 0 > "$dev/queue/iostats" 2>/dev/null
		fi
	done

	# Set walt governor on available cpufreq policies (onyx: policy0, policy2, policy5, policy7)
	LOGMSG "Setting CPU scaling governors to walt..."
	for p in /sys/devices/system/cpu/cpufreq/policy*; do
		if [ -e "$p/scaling_governor" ]; then
			if grep -q "walt" "$p/scaling_available_governors" 2>/dev/null; then
				echo walt > "$p/scaling_governor" 2>/dev/null
			fi
		fi
	done

	LOGMSG "I/O optimization complete."
}

SCRIPT_NAME="$(basename "$0")"

LOGMSG "---$SCRIPT_NAME start---"

optimize_io_and_cpu

/sbin/prune_historic_logs.sh 10 2>/dev/null

LOGMSG "---$SCRIPT_NAME end---"
exit 0

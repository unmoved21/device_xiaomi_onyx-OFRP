# Copyright (C) 2025-2026 OrangeFox Recovery Project
# SPDX-License-Identifier: GPL-3.0-only

# OrangeFox maintainer
OF_MAINTAINER := UnmoveD

# Screen settings
OF_SCREEN_H := 2772
OF_STATUS_H := 115
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 1
OF_STATUS_INDENT_LEFT := 56
OF_STATUS_INDENT_RIGHT := 48
OF_ALLOW_DISABLE_NAVBAR := 0
OF_USE_GREEN_LED := 0

# A/B partitioning
OF_AB_DEVICE_WITH_RECOVERY_PARTITION := 1
OF_ENABLE_ALL_PARTITION_TOOLS := 1

# Number of list options before scrollbar creation
OF_OPTIONS_LIST_NUM := 11

# Set this to 1 to force the selection of f2fs when formatting data
OF_FORCE_DATA_FORMAT_F2FS := 1

# Ensure that /sdcard is unbinded before /data repair/format
OF_UNBIND_SDCARD_F2FS := 1

# Wipe /metadata after /data format
OF_WIPE_METADATA_AFTER_DATAFORMAT := 1

# Avoid MTP issues after data format
OF_BIND_MOUNT_SDCARD_ON_FORMAT := 1

# Ignore the loop block errors after flashing ZIPs
OF_LOOP_DEVICE_ERRORS_TO_LOG := 1

# Do not check Treble compatibility
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1

# use lz4 compression (don't duplicate the setting - already set by "BOARD_RAMDISK_USE_LZ4 := true")
OF_USE_LZ4_COMPRESSION := 1

# use dmctl to work around problems with formatting the /data partition
OF_USE_DMCTL := 1

# Quick backup (Boot, callibration data)
OF_QUICK_BACKUP_LIST := /boot;/data;

# Recovery additional features	
OF_ENABLE_LPTOOLS := 1

# Set this to 1 to avoid the new 'NO KERNEL CONFIG' error, when using a prebuilt kernel
OF_FORCE_PREBUILT_KERNEL := 1

# Set to 1 to force the casefolding props to true. Useful for devices that shipped with Android 11+/FBEv2, where casefolding is always used
OF_FORCE_CASEFOLDING := 1

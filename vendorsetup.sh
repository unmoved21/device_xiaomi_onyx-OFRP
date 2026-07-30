#!/bin/bash

# Copyright (C) 2025-2026 OrangeFox Recovery Project
# SPDX-License-Identifier: GPL-3.0-only

FDEVICE="onyx"

fox_get_target_device() {
    local chkdev=""

    if [ -n "$ZSH_VERSION" ];
      then
        local current_source="${(%):-%x}"
        chkdev=$(echo "$current_source" | grep -w "$FDEVICE")
    elif [ -n "$BASH_VERSION" ];
      then chkdev=$(echo "$BASH_SOURCE" | grep -w "$FDEVICE")
    fi

    if [ -n "$chkdev" ];
      then FOX_BUILD_DEVICE="$FDEVICE"
    else
        if [ -n "$BASH_VERSION" ];
          then chkdev=$(set | grep BASH_ARGV | grep -w "$FDEVICE")
        elif [ -n "$ZSH_VERSION" ];
          then chkdev=$(echo "$*" | grep -w "$FDEVICE")
        fi
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ];
  then fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ];
  then
    export TARGET_DEVICE_ALT="onyx"
    export LC_ALL="C"
    export FOX_AB_DEVICE=1
    export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
    export OF_USE_LZ4_COMPRESSION=1
    export FOX_USE_TAR_BINARY=1
    export FOX_USE_SED_BINARY=1
    export FOX_USE_LZ4_BINARY=1
    export FOX_USE_ZSTD_BINARY=1
    export FOX_USE_DATE_BINARY=1
    export OF_TWRP_COMPATIBILITY_MODE=1
    export OF_NO_RELOAD_AFTER_DECRYPTION=1
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    export FOX_DELETE_AROMAFM=1
    export OF_USE_GREEN_LED=0
    export FOX_VANILLA_BUILD=1
    export OF_NO_MIUI_PATCH_WARNING=1
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
    export FOX_USE_GREP_BINARY=1
    export FOX_USE_BUSYBOX_BINARY=1
    export FOX_USE_XZ_UTILS=1
    export OF_FORCE_PREBUILT_KERNEL=1
    export OF_ENABLE_LPTOOLS=1
    export OF_ENABLE_ALL_PARTITION_TOOLS=1
    export FOX_VIRTUAL_AB_DEVICE=1
    export OF_DYNAMIC_FULL_SIZE=11811160064
    export OF_ENABLE_FS_COMPRESSION=1
    export OF_ENABLE_FRP_ADDON=1
    export OF_DISPLAY_FORMAT_FILESYSTEMS_DEBUG_INFO=1
    export FOX_SETTINGS_ROOT_DIRECTORY=/persist
    export FOX_ALLOW_EARLY_SETTINGS_LOAD=1
    export OF_UNBIND_SDCARD_F2FS=1
    export OF_WIPE_METADATA_AFTER_DATAFORMAT=1
    export FOX_USE_UPDATED_MAGISKBOOT=1
    export OF_FORCE_DATA_FORMAT_F2FS=1
    export FOX_MOVE_MAGISK_INSTALLER_TO_RAMDISK=1
    export FOX_USE_FSCK_EROFS_BINARY=1
    export FOX_USE_PATCHELF_BINARY=1
    export OF_OPTIONS_LIST_NUM=6
    export OF_USE_DMCTL=1
    export OF_USE_AIDL_BOOT_CONTROL=1
    export FOX_ENABLE_KERNELSU_SUPPORT=1
    export FOX_ENABLE_KERNELSU_NEXT_SUPPORT=1
    export FOX_ENABLE_SUKISU_SUPPORT=1

    # For Xiaomi Onyx
    export OF_MAINTAINER="UnmoveD"
    export OF_SCREEN_H=2400
    export OF_STATUS_H=116
    export OF_STATUS_INDENT_LEFT=30
    export OF_STATUS_INDENT_RIGHT=30
    export OF_HIDE_NOTCH=1
    export OF_ALLOW_DISABLE_NAVBAR=0

    # CCACHE
    export USE_CCACHE=1
    export CCACHE_EXEC="/usr/bin/ccache"
    export CCACHE_MAXSIZE="50G"
    export CCACHE_DIR="/mnt/ccache"

    # Warn if CCACHE_DIR is an invalid directory
    if [ $USE_CCACHE = 1 ] && [ ! -d ${CCACHE_DIR} ];
     then
       echo "CCACHE Directory/Partition is not mounted at \"${CCACHE_DIR}\""
       echo "Please edit the CCACHE_DIR build variable or mount the directory."
    fi

    export LC_ALL="C"
    export BUILD_USERNAME=unmoved
    export BUILD_HOSTNAME=github

  else
    if [ -z "$FOX_BUILD_DEVICE" ] && [ -z "$BASH_SOURCE" ] && [ -z "$ZSH_VERSION" ]; 
      then echo "I: This script requires bash or zsh. Not processing $FDEVICE"
    fi
fi

#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/onyx

# Allow for building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_USES_NETWORK := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# Architecture
TARGET_ARCH                := arm64
TARGET_ARCH_VARIANT        := armv8-a
TARGET_CPU_ABI             := arm64-v8a
TARGET_CPU_ABI2            := 
TARGET_CPU_VARIANT         := generic
TARGET_CPU_VARIANT_RUNTIME := oryon

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
TARGET_NO_BOOTLOADER := true

# Display
TARGET_USES_VULKAN := true

# Power
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Kernel / Recovery image
TARGET_PREBUILT_KERNEL    := $(DEVICE_PATH)/prebuilt/kernel
TARGET_KERNEL_ARCH        := $(TARGET_ARCH)
TARGET_KERNEL_HEADER_ARCH := $(TARGET_ARCH)

BOARD_KERNEL_PAGESIZE     := 4096
BOARD_KERNEL_IMAGE_NAME   := kernel
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS      += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS      += --pagesize $(BOARD_KERNEL_PAGESIZE)

# Generic system/kernel image
BOARD_USES_GENERIC_KERNEL_IMAGE          := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT   := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# Use LZ4 Ramdisk compression instead of GZIP
BOARD_RAMDISK_USE_LZ4 := true

# Partitions
BOARD_RECOVERYIMAGE_PARTITION_SIZE   := 104857600
BOARD_HAS_LARGE_FILESYSTEM           := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE   := ext4
TARGET_COPY_OUT_VENDOR               := vendor
TARGET_COPY_OUT_VENDOR_DLKM          := vendor_dlkm

# Dynamic Partition
BOARD_SUPER_PARTITION_SIZE                  := 11811160064
BOARD_SUPER_PARTITION_GROUPS                := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE           := 11809841488
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Filesystems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS         := true

# Platform
TARGET_BOOTLOADER_BOARD_NAME := onyx
TARGET_BOARD_PLATFORM        := sun
TARGET_BOARD_PLATFORM_GPU    := qcom-adreno825
TARGET_USES_UEFI             := true
BOARD_USES_QCOM_HARDWARE     := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Debug
TARGET_USES_LOGD := true

TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace

TARGET_SYSTEM_PROP := \
 $(DEVICE_PATH)/system.prop

TARGET_RECOVERY_FSTAB := \
 $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

TARGET_BOARD_INFO_FILE := \
 $(DEVICE_PATH)/board-info.txt

# Verified Boot
BOARD_AVB_ENABLE                 := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

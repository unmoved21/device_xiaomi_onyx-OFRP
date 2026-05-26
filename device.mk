#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/onyx
# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit_only.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Configure Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Configure virtual_ab compression.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure twrp common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
 boot \
 init_boot \
 vendor_boot \
 dtbo \
 vbmeta \
 vbmeta_system \
 odm \
 product \
 system \
 system_ext \
 system_dlkm \
 vendor \
 vendor_dlkm

# TWRP - Specifics
TW_THEME                := portrait_hdpi
TW_INPUT_BLACKLIST      := "hbtp_vm"
TW_DEFAULT_LANGUAGE     := en
TW_USE_TOOLBOX          := true
TW_INCLUDE_LPDUMP       := true
TW_INCLUDE_LPTOOLS      := true
TW_INCLUDE_NTFS_3G      := true
TW_INCLUDE_REPACKTOOLS  := true
TW_INCLUDE_RESETPROP    := true
TW_INCLUDE_LIBRESETPROP := true
TW_MAX_BRIGHTNESS       := 2047
TW_EXTRA_LANGUAGES      := true
TW_DEFAULT_BRIGHTNESS   := 250
TW_EXCLUDE_APEX         := true
TW_INCLUDE_FASTBOOTD    := true
TWRP_INCLUDE_LOGCAT     := true
TW_INCLUDE_PYTHON       := true
TW_NO_SCREEN_BLANK      := true
TW_FRAMERATE            := 120
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_HAS_EDL_MODE := true
TW_BATTERY_SYSFS_WAIT_SECONDS := 6

# Vendor modules required for the recovery to function properly
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko nt38771_touch.ko nxp-nci.ko xiaomi_touch.ko"

TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone48/temp"
TW_BRIGHTNESS_PATH      := "/sys/class/backlight/panel0-backlight/brightness"

# OTA device(s)
TARGET_OTA_ASSERT_DEVICE := onyx

# API
PRODUCT_SHIPPING_API_LEVEL  := 34
PRODUCT_TARGET_VNDK_VERSION := 34
BOARD_SHIPPING_API_LEVEL := 34
SHIPPING_API_LEVEL := 34

# Display Size & Density
TARGET_SCREEN_HEIGHT := 2712
TARGET_SCREEN_WIDTH  := 1220
TARGET_SCREEN_DENSITY := 480

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION  := false

# Boot control HAL
PRODUCT_PACKAGES += \
    bootctrl.sun.recovery \
    android.hardware.boot@1.2-impl-qti.recovery

# TWRP - Crypto
TW_INCLUDE_CRYPTO               := true
TW_INCLUDE_CRYPTO_FBE           := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_INCLUDE_OMAPI                := true
BOARD_USES_QCOM_FBE_DECRYPTION  := true
TW_USE_FSCRYPT_POLICY := 2
BOARD_USES_METADATA_PARTITION := true

PLATFORM_VERSION                := 99.87.36
PLATFORM_VERSION_LAST_STABLE    := $(PLATFORM_VERSION)

PLATFORM_SECURITY_PATCH := 2127-12-31
VENDOR_SECURITY_PATCH   := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH     := $(PLATFORM_SECURITY_PATCH)

# AIDL Haptics
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/vibratorfeature"
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true

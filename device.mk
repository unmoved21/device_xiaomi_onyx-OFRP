#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/onyx

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

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service

PRODUCT_PACKAGES += \
    bootctrl.sun

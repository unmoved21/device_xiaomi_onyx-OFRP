#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/onyx

# Inherit from device.mk configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

## Device identifier
PRODUCT_DEVICE := onyx
PRODUCT_NAME := twrp_onyx
PRODUCT_BRAND := POCO
PRODUCT_MODEL := 25053PC47G
PRODUCT_MANUFACTURER := xiaomi

# Theme
TW_STATUS_ICONS_ALIGN := center

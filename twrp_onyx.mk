#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from onyx device
$(call inherit-product, device/xiaomi/onyx/device.mk)

# Import OrangeFox specifics
$(call inherit-product, device/xiaomi/onyx/fox_onyx.mk)

PRODUCT_DEVICE := onyx
PRODUCT_NAME := twrp_onyx
PRODUCT_BRAND := POCO
PRODUCT_MODEL := 25053PC47G
PRODUCT_MANUFACTURER := xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi



#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

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



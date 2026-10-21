# Copyright (C) 2025 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# PixelOS product: lineage_a30.mk with PixelOS's vendor/custom config, which
# inherits vendor/lineage itself. PixelOS's breakfast/brunch use custom_<device>.

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

# Inherit PixelOS common device config (includes LineageOS's)
$(call inherit-product, vendor/custom/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/a30/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := a30
PRODUCT_NAME := custom_a30
PRODUCT_MODEL := SM-A305F
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="a30cis-user 11 RP1A.200720.012 A305FNXXU6CUI2 release-keys" \
    BuildFingerprint=samsung/a30cis/a30:11/RP1A.200720.012/A305FNXXU6CUI2:user/release-keys

#
# Copyright (C) 2015-2016 The CyanogenMod Project
#           (C) 2017-2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

TARGET_BOOT_ANIMATION_RES := 1080

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from helium device
$(call inherit-product, device/xiaomi/helium/device.mk)

# GApps
$(call inherit-product-if-exists, vendor/gapps/config.mk)

# PixelStyle
$(call inherit-product-if-exists, vendor/pixelstyle/config.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/aosip/config/common_full_phone.mk)

# GApps targets
TARGET_GAPPS_ARCH := arm64
IS_PHONE := true

# Set those variables here to overwrite the inherited values.
BOARD_VENDOR := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_DEVICE := helium
PRODUCT_NAME := aosip_helium
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := Mi Max
TARGET_VENDOR := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Use the latest approved GMS identifiers unless running a signed build
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="helium-user 6.0.1 MMB29M V8.2.3.0.MBCCNDL release-keys"

BUILD_FINGERPRINT := Xiaomi/helium/helium:6.0.1/MMB29M/V8.2.3.0.MBCCNDL:user/release-keys
#
# Copyright (C) 2020 The LineageOS Project
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

BUILD_TOP := $(shell pwd)

PLATFORM_PATH := device/samsung/universal9611-common

# Platform
TARGET_BOARD_PLATFORM := universal9611
TARGET_SOC := exynos9611
TARGET_BOOTLOADER_BOARD_NAME := universal9611
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Enable hardware/samsung
BOARD_VENDOR := samsung

### PROCESSOR
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_SMP := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

### RELASETOOLS
#TARGET_RELEASETOOLS_EXTENSIONS := $(PLATFORM_PATH)/releasetools

### RENDERSCRIPT
OVERRIDE_RS_DRIVER := libRSDriverArm.so

### HARDWARE INCLUDE
TARGET_SPECIFIC_HEADER_PATH := $(PLATFORM_PATH)/hardware/include

### KERNEL
TARGET_KERNEL_SOURCE = kernel/samsung/m21
TARGET_KERNEL_CLANG_COMPILE := true

BOARD_CUSTOM_BOOTIMG         := true
BOARD_CUSTOM_BOOTIMG_MK      := $(PLATFORM_PATH)/kernel/mkbootimg.mk
BOARD_KERNEL_BASE            := 0x10000000
# See `bbootimg -i boot.img`
BOARD_KERNEL_PAGESIZE        := 2048
# Looks like Samsung's sboot doesn't suppored a zipped Kernel
BOARD_KERNEL_IMAGE_NAME      := Image
# Build a device tree overlay
BOARD_KERNEL_SEPARATED_DTBO  := true
BOARD_DTBO_CFG               := $(PLATFORM_PATH)/../$(TARGET_DEVICE)/kernel/$(TARGET_DEVICE).cfg
#TARGET_BOOTLOADER_IS_2ND := true

# See `bbootimg -i boot.img`
BOARD_DTB_OFFSET              := 0x00000000
BOARD_KERNEL_OFFSET          := 0x00008000
BOARD_KERNEL_RAMDISK_OFFSET  := 0x01000000
BOARD_KERNEL_TAGS_OFFSET     := 0x00000100

# See `bbootimg -i boot.img`
BOARD_BOOT_HEADER_VERSION    := 2
BOARD_BOOT_HEADER_NAME       := SRPSL20A002KU

BOARD_MKBOOTIMG_ARGS := --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_KERNEL_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --board $(BOARD_BOOT_HEADER_NAME)

### CACHE
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

### AUDIO
USE_XML_AUDIO_POLICY_CONF := 1

### BLUETOOTH
BOARD_HAVE_BLUETOOTH_SLSI := true

BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(PLATFORM_PATH)/hardware/bluetooth
BOARD_CUSTOM_BT_CONFIG := $(PLATFORM_PATH)/hardware/bluetooth/libbt_vndcfg.txt

### DISPLAY
TARGET_SCREEN_DENSITY := 240

### HIDL
DEVICE_MANIFEST_FILE += $(PLATFORM_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(PLATFORM_PATH)/compatibility_matrix.xml

### KEYMASTER
TARGET_KEYMASTER_VARIANT := samsung

### SEPOLICY
include device/lineage/sepolicy/exynos/sepolicy.mk

BOARD_SEPOLICY_TEE_FLAVOR := teegris
include device/samsung_slsi/sepolicy/sepolicy.mk

BOARD_VENDOR_SEPOLICY_DIRS += $(PLATFORM_PATH)/sepolicy/vendor

### PARTITIONS
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_BOOTIMAGE_PARTITION_SIZE := 61865984
BOARD_CACHEIMAGE_PARTITION_SIZE := 209715200
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 71106560
BOARD_DTBOIMG_PARTITION_SIZE := 8388608

# Filesystem
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# PARTITION_LIST
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    vendor \
    product \
    odm

# BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE is set to BOARD_SUPER_PARTITION_SIZE / 2 - 4MB
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE := 3182952448

# Set error limit to BOARD_SUPER_PARTITION_SIZE - 500MB
BOARD_SUPER_PARTITION_ERROR_LIMIT := 5858394112


### PROPERTIES
TARGET_SYSTEM_PROP += $(PLATFORM_PATH)/system.prop
TARGET_PRODUCT_PROP += $(PLATFORM_PATH)/product.prop
TARGET_VENDOR_PROP += $(PLATFORM_PATH)/vendor.prop


### WIFI
BOARD_WLAN_DEVICE                := slsi
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_slsi
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_slsi
WIFI_DRIVER_FW_PATH_PARAM        := /sys/module/scsc_mx/parameters/base_dir

PRODUCT_CFI_INCLUDE_PATHS        += hardware/samsung_slsi/scsc_wifibt/wpa_supplicant_lib

WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true

# hardware/broadcom/wlan/bcmdhd/config/Android.mk
# external/wpa_supplicant_8/Android.mk
WPA_SUPPLICANT_VERSION           := VER_0_8_X

### RIL
# Use stock RIL stack
ENABLE_VENDOR_RIL_SERVICE := true

### ALLOW VENDOR FILE OVERRIDE
BUILD_BROKEN_DUP_RULES := true

### RECOVERY
BOARD_HAS_DOWNLOAD_MODE := true
TARGET_RECOVERY_PIXEL_FORMAT := "ABGR_8888"
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_FSTAB := $(PLATFORM_PATH)/config/init/fstab.exynos9611

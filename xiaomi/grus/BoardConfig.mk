#
# Copyright 2017 The Android Open Source Project
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

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

DEVICE_PATH := device/xiaomi/grus

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

TARGET_USES_64_BIT_BINDER := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm710
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xA90000 androidboot.hardware=qcom androidboot.console=ttyMSM0
BOARD_KERNEL_CMDLINE += video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += service_locator.enable=1 androidboot.configfs=true androidboot.usbcontroller=a600000.dwc3 swiotlb=1
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/firmware_mnt/image loop.max_part=7
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET     := 0x01000000
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz-dtb

# Recovery DTBO
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_BOOTIMG_HEADER_VERSION := 1
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img

# Platform
TARGET_BOARD_PLATFORM := sdm710
TARGET_BOARD_PLATFORM_GPU := qcom-adreno616

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144

BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3758096384
BOARD_USERDATAIMAGE_PARTITION_SIZE := 119613140992
BOARD_VENDORIMAGE_PARTITION_SIZE := 1610612736

BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true

# Android Verified Boot
BOARD_AVB_ENABLE := false
BOARD_BUILD_DISABLED_VBMETAIMAGE := true

# Crypto
TW_INCLUDE_CRYPTO := true
TARGET_HW_DISK_ENCRYPTION := true
ifeq ($(shell test $(PLATFORM_SDK_VERSION) -ge 28; echo $$?),0)
TW_INCLUDE_CRYPTO_FBE := true
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.weaver@1.0.so
endif

# TWRP specific build flags
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
BOARD_HAS_NO_REAL_SDCARD := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_EXCLUDE_DEFAULT_USB_INIT := true
#TW_USE_TOOLBOX := true
TW_Y_OFFSET := 80
TW_H_OFFSET := -80

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31

# CUSTOMIZATION by IceMan

# LZMA compression for recovery's & kernel ramdisk....
LZMA_RAMDISK_TARGETS := recovery

# Asian region languages
TW_EXTRA_LANGUAGES := true

# Exclude Supersu
TW_EXCLUDE_SUPERSU := true

# View button bootloader
TW_NO_REBOOT_BOOTLOADER := false

# View button downloadmode - true only samsung
TW_HAS_DOWNLOAD_MODE := false

# View button edl mode 
#TW_HAS_EDL_MODE := true

# exclude Twrp app
TW_EXCLUDE_TWRPAPP := true

# Default Brightness (TW_DEFAULT_BRIGHTNESS=1023-->100%; TW_DEFAULT_BRIGHTNESS=870-->85%)
#TW_DEFAULT_BRIGHTNESS := 1023
#TW_MAX_BRIGHTNESS := 1023

# Use ro.product.model
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true

# NTFS support
TW_INCLUDE_NTFS_3G := true

# Set language default
TW_DEFAULT_LANGUAGE := en

# For Version TWRP
#TW_SPECIFIC_VERSION_STR := ""
TW_DEVICE_VERSION := "MI9 SE by IceMan"

# For time custom
TW_SPECIFIC_TIME_ZONE_VAR := "CET-1CEST,M3.5.0,M10.5.0"
TW_SPECIFIC_TIME_ZONE_GUISEL := "CET-1;CEST,M3.5.0,M10.5.0"

# For H24 hours
TW_SPECIFIC_MILITARY_TIME := "1"

# For Screen_timeout_secs
TW_SCREEN_TIMEOUT_SECS := "120"

#For reverse navbar (default "0")
TW_SPECIFIC_SAMSUNG_NAVBAR := "0"
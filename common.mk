# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file includes all definitions that apply to ALL Amazon Kindle Fire devices, and
# are also specific to otter devices
#
# Everything in this directory will become public

COMMON_FOLDER := device/sd/sd-common

# set to allow building from omap4-common
BOARD_VENDOR := sd

# Setup custom omap4xxx defines
#BOARD_USE_CUSTOM_LIBION := true

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := $(DEVICE_FOLDER)/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    hardware/ti/wpan/tools/FM/FmRadioIf/com.ti.fm.fmradioif.xml:system/etc/permissions/com.ti.fm.fmradioif.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    $(call add-to-product-copy-files-if-exists,packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml)

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=120 \
    ro.opengles.version=131072 \
    com.ti.omap_enhancement=true \
    omap.enhancement=true \
    ro.crypto.state=unencrypted \
    persist.sys.usb.config=mtp,adb \
    persist.sys.root_access=3 \
    ro.sf.lcd_density=160 \
    ro.nf.profile=2 \
    ro.nf.level=512

PRODUCT_CHARACTERISTICS := tablet

DEVICE_PACKAGE_OVERLAYS := $(DEVICE_FOLDER)/overlay/aosp

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Rootfs
PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel \
    $(COMMON_FOLDER)/default.prop:/root/default.prop \

# Wifi
PRODUCT_PACKAGES += \
    ti_wfd_libs \
    dhcpcd.conf \
    lib_driver_cmd_wl12xx \
    TQS_D_1.7.ini \
    calibrator \
    hostapd.conf \
    

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    sdcard \
    setup_fs \

# Audio Support
PRODUCT_PACKAGES += \
    libaudioutils \
    Music \
    tinyplay \
    tinymix \
    tinycap \
    audio_policy.default \
    audio.a2dp.default \
    audio.usb.default \
    audio.hdmi.omap4 \
    audio.r_submix.default \
    audio.primary.omap4 \
    camera.omap4 \
    gps.omap4 \

# DRM
PRODUCT_PACKAGES += \
    libwvm \

# Misc / Testing
PRODUCT_PACKAGES += \
    evtest \
    strace \
    libjni_pinyinime \
    sh \

# Extra apps (not always included by AOSP)
PRODUCT_PACKAGES += \
    Email \

PRODUCT_PACKAGES += \
    hwcomposer.default \

PRODUCT_AAPT_PREF_CONFIG := mdpi
# BT
PRODUCT_PACKAGES += \
    uim-sysfs \
    libbt-vendor

# Prebuilts /system/etc
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/prebuilt/etc/audio_policy.conf:/system/etc/audio_policy.conf \
    $(COMMON_FOLDER)/prebuilt/etc/media_codecs.xml:/system/etc/media_codecs.xml \
    $(COMMON_FOLDER)/prebuilt/etc/media_profiles.xml:/system/etc/media_profiles.xml \
    $(COMMON_FOLDER)/prebuilt/etc/mixer_paths.xml:/system/etc/mixer_paths.xml \
    $(COMMON_FOLDER)/prebuilt/etc/smc_normal_world_android_cfg.ini:/system/etc/smc_normal_world_android_cfg.ini \

# Input
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/prebuilt/usr/idc/ft5x0x_ts.idc:system/usr/idc/ft5x0x_ts.idc \
    $(COMMON_FOLDER)/prebuilt/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(COMMON_FOLDER)/prebuilt/usr/keylayout/twl6030_pwrbutton.kl:system/usr/keylayout/twl6030_pwrbutton.kl \

# USB Host app switcher
PRODUCT_PACKAGES += USBHostSwitcher

# TI OMAP4
PRODUCT_PACKAGES += \
    libdomx \
    libOMX_Core \
    libOMX.TI.DUCATI1.VIDEO.H264E \
    libOMX.TI.DUCATI1.VIDEO.H264SVCE \
    libOMX.TI.DUCATI1.VIDEO.VC1E \
    libOMX.TI.DUCATI1.VIDEO.MPEG4E \
    libOMX.TI.DUCATI1.VIDEO.DECODER \
    libOMX.TI.DUCATI1.VIDEO.DECODER.secure \
    libOMX.TI.DUCATI1.MISC.SAMPLE \
    libstagefrighthw \
    libI420colorconvert \
    libtiutils_custom \
    libcamera \
    libion_ti \
    libomxcameraadapter \
    smc_pa_ctrl \
    tf_daemon \
    libtf_crypto_sst \
    libOMX.TI.DUCATI1.VIDEO.CAMERA \

# Standard CM stuff.
PRODUCT_PACKAGES += \
    hwprops \
    CMStats \

# Hardware HALs
PRODUCT_PACKAGES += \
    lights.$(TARGET_BOOTLOADER_BOARD_NAME) \
    power.$(TARGET_BOOTLOADER_BOARD_NAME) \
    audio.primary.$(TARGET_BOOTLOADER_BOARD_NAME) \
    sensors.$(TARGET_BOOTLOADER_BOARD_NAME) \
    audio.hdmi.$(TARGET_BOOTLOADER_BOARD_NAME) \
#    hwcomposer.$(TARGET_BOOTLOADER_BOARD_NAME) \
    
# Clears the boot counter, update mac address on first start
PRODUCT_COPY_FILES += \
        $(COMMON_FOLDER)/prebuilt/bin/clear_bootcnt.sh:/system/bin/clear_bootcnt.sh \
	$(COMMON_FOLDER)/prebuilt/bin/fix-mac.sh:/system/bin/fix-mac.sh

# Art
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/prebuilt/poetry/poem.txt:root/sbin/poem.txt
    

#TI_WPAN
PRODUCT_PACKAGES += uim-sysfs \
	bt_sco_app \
	kfmapp     \
        BluetoothSCOApp \
        FmRxApp \
        FmTxApp \
        FmService \
        libfmradio \
        fmradioif \
        com.ti.fm.fmradioif.xml \
        libbt-vendor \

#copy firmware
PRODUCT_COPY_FILES += \
  device/ti/proprietary-open/wl12xx/wpan/bluetooth/TIInit_10.6.15.bts:system/etc/firmware/TIInit_10.6.15.bts \
  device/ti/proprietary-open/wl12xx/wpan/bluetooth/TIInit_7.2.31.bts:system/etc/firmware/TIInit_7.2.31.bts \
  device/ti/proprietary-open/wl12xx/wpan/bluetooth/TIInit_7.6.15.bts:system/etc/firmware/TIInit_7.6.15.bts \
  device/ti/proprietary-open/wl12xx/wpan/bluetooth/TIInit_12.7.27.bts:system/etc/firmware/TIInit_12.7.27.bts \
  device/ti/proprietary-open/wl12xx/wpan/fmradio/fmc_ch8_1283.2.bts:system/etc/firmware/fmc_ch8_1283.2.bts \
  device/ti/proprietary-open/wl12xx/wpan/fmradio/fm_rx_ch8_1283.2.bts:system/etc/firmware/fm_rx_ch8_1283.2.bts \
  device/ti/proprietary-open/wl12xx/wpan/fmradio/fm_tx_ch8_1283.2.bts:system/etc/firmware/fm_tx_ch8_1283.2.bts \
  device/ti/proprietary-open/wl12xx/wpan/fmradio/fmc_init_1273.2.bts:system/etc/firmware/fmc_init_1273.2.bts \
  device/ti/proprietary-open/wl12xx/wpan/fmradio/fm_rx_init_1273.2.bts:system/etc/firmware/fm_rx_init_1273.2.bts \
  device/ti/proprietary-open/wl12xx/wpan/fmradio/fm_tx_init_1273.2.bts:system/etc/firmware/fm_tx_init_1273.2.bts \
  device/ti/proprietary-open/wl12xx/wpan/fmradio/fm_tx_ch8_1273.1.bts:system/etc/firmware/fm_tx_ch8_1273.1.bts \
  device/ti/proprietary-open/wl12xx/wpan/fmradio/fm_tx_ch8_1273.2.bts:system/etc/firmware/fm_tx_ch8_1273.2.bts \

$(call inherit-product-if-exists, vendor/sd/omap4470-common/omap4470-common-vendor.mk)

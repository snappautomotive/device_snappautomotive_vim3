TARGET_VIM3 := true
TARGET_USE_TABLET_LAUNCHER := true
TARGET_USES_CAR_FUTURE_FEATURES := true

BOARD_IS_AUTOMOTIVE := true
PRODUCT_DISPLAY_DENSITY := 160

# EVS - Use the mocked EVS from the emulator builds. This can be replaced
# with a full EVS HAL implementation to integrate with the VIM3 hardware
# at a later date.
ENABLE_EVS_SAMPLE := true
ENABLE_EVS_SERVICE := true
ENABLE_MOCK_EVSHAL := true
ENABLE_SAMPLE_EVS_APP := false

ENABLE_CAREVSSERVICE_SAMPLE := true

ENABLE_CAMERA_SERVICE := true
ENABLE_REAR_VIEW_CAMERA_SAMPLE := true

ENABLE_CARTELEMETRY_SERVICE := true

$(call inherit-product, device/snappautomotive/common/additions.mk)
$(call inherit-product, device/amlogic/yukawa/yukawa.mk)
$(call inherit-product, packages/services/Car/car_product/build/car.mk)
$(call inherit-product, frameworks/base/data/fonts/fonts.mk)

PRODUCT_PACKAGES += \
	android.hardware.automotive.audiocontrol-service.example \
	android.hardware.automotive.vehicle@2.0-service \
	android.hardware.automotive.evs.manager@1.1 \
	android.hardware.automotive.evs@1.1-sample \
	android.hardware.broadcastradio@2.0-service \
	CarConnectivityOverlay \
	CarWifiOverlay \
	librs_jni

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/aosp_excluded_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/aosp_excluded_hardware.xml \
	frameworks/native/data/etc/car_core_hardware.xml:system/etc/permissions/car_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.broadcastradio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.broadcastradio.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.screen.landscape.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.screen.landscape.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.type.automotive.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.type.automotive.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
	frameworks/native/data/etc/android.software.activities_on_secondary_displays.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.activities_on_secondary_displays.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.ar.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.autofocus.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.concurrent.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.any.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
	device/generic/car/common/android.hardware.disable.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
	device/google_car/common/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml

PRODUCT_PROPERTY_OVERRIDES += \
	android.car.drawer.unlimited=true \
	android.car.hvac.demo=true \
	com.android.car.radio.demo=true \
	com.android.car.radio.demo.dual=true \
	ro.boot.wificountrycode=00 \
	ro.carwatchdog.vhal_healthcheck.interval=10 \
	ro.config.media_vol_default=0 \
	ro.hardware.egl=mali

PRODUCT_COPY_FILES += \
	packages/services/Car/car_product/init/init.bootstat.rc:root/init.bootstat.rc \
	packages/services/Car/car_product/init/init.car.rc:root/init.car.rc

DEVICE_MANIFEST_FILE += \
	device/snappautomotive/vim3/manifest.xml

# CAN bus support - We don't have a direct hardware interface on the
# VIM3, but there are dongles which can provide CAN bus connectivity

PRODUCT_PACKAGES += \
	android.hardware.automotive.can@1.0-service
PRODUCT_PACKAGES_DEBUG += \
	canhalctrl \
	canhaldump \
	canhalsend

# Occupant Awareness

PRODUCT_PACKAGES_DEBUG += \
	android.hardware.automotive.occupant_awareness@1.0-service \
	android.hardware.automotive.occupant_awareness@1.0-service_mock

# Sepolicy for occupant awareness system
include packages/services/Car/car_product/occupant_awareness/OccupantAwareness.mk

# Copy APN configs
PRODUCT_COPY_FILES += \
    device/generic/goldfish/data/etc/apns-conf.xml:system/etc/apns-conf.xml \
    device/sample/etc/old-apns-conf.xml:system/etc/old-apns-conf.xml

PRODUCT_PROPERTY_OVERRIDES += \
        ro.boot.wificountrycode=00 \
        ro.config.media_vol_default=0 \
        log.tag.CarTrustAgentUnlockEvent=I

PRODUCT_NAME := snapp_car_vim3
PRODUCT_BRAND := Android
ifeq ($(SNAPP_MODEL),)
PRODUCT_MODEL := Snapp Automotive build of Android Automotive OS for VIM3
else
PRODUCT_MODEL := $(SNAPP_MODEL)
endif


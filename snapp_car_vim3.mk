TARGET_VIM3 := true
TARGET_USE_TABLET_LAUNCHER := true

BOARD_IS_AUTOMOTIVE := true
PRODUCT_DISPLAY_DENSITY := 160

# EVS - Use the mocked EVS from the emulator builds. This can be replaced
# with a full EVS HAL implementation to integrate with the VIM3 hardware
# at a later date.
ENABLE_EVS_SAMPLE := false
ENABLE_EVS_SERVICE := true
ENABLE_MOCK_EVSHAL := true
ENABLE_SAMPLE_EVS_APP := false

ENABLE_CAREVSSERVICE_SAMPLE := true

ENABLE_CAMERA_SERVICE := true
ENABLE_REAR_VIEW_CAMERA_SAMPLE := true

ENABLE_CARTELEMETRY_SERVICE := true

# CarServiceHelperService accesses the hidden api in the system server.
SYSTEM_OPTIMIZE_JAVA := false

DEVICE_FRAMEWORK_MANIFEST_FILE += device/google_car/common/manifest.xml

# generic_system.mk sets 'PRODUCT_ENFORCE_RRO_TARGETS := *'
# but this breaks phone_car. So undo it here.
PRODUCT_ENFORCE_RRO_TARGETS :=

# Enable mainline checking
PRODUCT_ENFORCE_ARTIFACT_PATH_REQUIREMENTS := false

# Set Car Service RRO
PRODUCT_PACKAGES += CarServiceOverlayPhoneCar
GOOGLE_CAR_SERVICE_OVERLAY += CarServiceOverlayPhoneCarGoogle

# Additional selinux policy
BOARD_SEPOLICY_DIRS += device/google_car/common/sepolicy

# Override heap growth limit due to high display density on device
PRODUCT_PROPERTY_OVERRIDES += \
            dalvik.vm.heapgrowthlimit=256m

# Exclude the testing apps
PRODUCT_IS_AUTOMOTIVE_SDK := true

PRODUCT_PACKAGE_OVERLAYS += device/snappautomotive/vim3/overlay

$(call inherit-product, device/snappautomotive/common/additions.mk)
$(call inherit-product, device/amlogic/yukawa/yukawa.mk)
$(call inherit-product, packages/services/Car/car_product/build/car.mk)
$(call inherit-product, frameworks/base/data/fonts/fonts.mk)

PRODUCT_PACKAGES += \
	android.hardware.automotive.vehicle@2.0-default-service \
	android.hardware.automotive.vehicle@V3-default-service \
	android.hardware.broadcastradio@2.0-service \
	android.hardware.broadcastradio \
	android.hardware.automotive.remoteaccess@V2-default-service \
	android.hardware.automotive.ivn@V1-default-service \
	CarConnectivityOverlay \
	CarWifiOverlay \
	librs_jni

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/aosp_excluded_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/aosp_excluded_hardware.xml \
	frameworks/native/data/etc/car_core_hardware.xml:system/etc/permissions/car_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.broadcastradio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.broadcastradio.xml \
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

PRODUCT_PROPERTY_OVERRIDES += \
	android.car.drawer.unlimited=true \
	android.car.hvac.demo=true \
	com.android.car.radio.demo=true \
	com.android.car.radio.demo.dual=true \
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
	canhalsend \
	android.hardware.automotive.occupant_awareness@1.0-service \
	android.hardware.automotive.occupant_awareness@1.0-service_mock

BOARD_SEPOLICY_DIRS += device/google_car/common/sepolicy

# Audio Control
PRODUCT_PACKAGES += \
            android.hardware.automotive.audiocontrol-service.example

# Sepolicy for occupant awareness system
include packages/services/Car/car_product/occupant_awareness/OccupantAwareness.mk

# Sepolicy for compute pipe system
include packages/services/Car/cpp/computepipe/products/computepipe.mk

PRODUCT_COPY_FILES += \
    device/google_car/common/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \

PRODUCT_PROPERTY_OVERRIDES += \
        ro.boot.wificountrycode=00 \
        ro.config.media_vol_default=0 \
        log.tag.CarTrustAgentUnlockEvent=I

# Phone car targets don't support ramdump
EXCLUDE_BUILD_RAMDUMP_UPLOADER_DEBUG_TOOL := true

# Disable RCS and EAB for phone car targets
PRODUCT_PRODUCT_PROPERTIES += \
        persist.rcs.supported=0 \
        persist.eab.supported=0

# Occupant Awareness

PRODUCT_PACKAGES_DEBUG += \
	android.hardware.automotive.occupant_awareness@1.0-service \
	android.hardware.automotive.occupant_awareness@1.0-service_mock

# Sepolicy for occupant awareness system
include packages/services/Car/car_product/occupant_awareness/OccupantAwareness.mk

PRODUCT_PROPERTY_OVERRIDES += \
        ro.boot.wificountrycode=00 \
        ro.config.media_vol_default=0 \
        log.tag.CarTrustAgentUnlockEvent=I

PRODUCT_NAME := snapp_car_vim3
PRODUCT_CHARACTERISTICS := automotive
ifeq ($(SNAPP_MODEL),)
PRODUCT_MODEL := Snapp Automotive build of Android Automotive OS for VIM3
else
PRODUCT_MODEL := $(SNAPP_MODEL)
endif


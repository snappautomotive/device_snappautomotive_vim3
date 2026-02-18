# See https://cs.android.com/android/platform/superproject/+/android-platform-14.0.0_r24:device/google_car/tangorpro_car/aosp_tangorpro_car.mk

# Bring in the VIM3 overlay first. This is because the overlay precedence is
# that overlays defined first have precedence. pre_google_car.mk brings in
# overlays which also define resources we too define - we want to override
# them, so we define this here first.
PRODUCT_PACKAGE_OVERLAYS += device/snappautomotive/vim3/overlay

# Bring in the required AOSP definitions before defining the car product.
$(call inherit-product, device/google_car/common/pre_google_car.mk)

# Used by yukawa.mk to know what board to build for.
TARGET_VIM3 := true
# Used by yukawa.mk to know if the tablet launcher should be used - this is
# overridden later.
TARGET_USE_TABLET_LAUNCHER := true
PHONE_CAR_BOARD_PRODUCT := snapp_car_vim3
BOARD_IS_AUTOMOTIVE := true
PRODUCT_DISPLAY_DENSITY := 160

# Exclude the testing apps.
PRODUCT_IS_AUTOMOTIVE_SDK := true

# Bring in the Snapp Automotive additions.
$(call inherit-product, device/snappautomotive/common/additions.mk)

# Bring in the VIM3 device definition.
$(call inherit-product, device/amlogic/yukawa/yukawa.mk)
# Bring in the base Android car product definition.
$(call inherit-product, packages/services/Car/car_product/build/car.mk)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/aosp_excluded_hardware.xml:system/etc/permissions/aosp_excluded_hardware.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:system/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.software.activities_on_secondary_displays.xml:system/etc/permissions/android.software.activities_on_secondary_displays.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.camera.ar.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.camera.concurrent.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.camera.full.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.camera.front.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.camera.any.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.camera.raw.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.fingerprint.xml \
    device/generic/car/common/android.hardware.disable.xml:system/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PROPERTY_OVERRIDES += \
    android.car.drawer.unlimited=true \
    android.car.hvac.demo=true \
    com.android.car.radio.demo=true \
    com.android.car.radio.demo.dual=true \
    ro.hardware.egl=mali

PRODUCT_PRODUCT_PROPERTIES += \
    ro.adb.secure=0

PRODUCT_PACKAGES += \
    librs_jni

DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += \
    device/snappautomotive/vim3/automotive_framework_compatibility_matrix.xml

# Bring in the required AOSP definitions after defining the car product.
$(call inherit-product, device/google_car/common/post_google_car.mk)

PRODUCT_NAME := snapp_car_vim3
PRODUCT_CHARACTERISTICS := automotive
ifeq ($(SNAPP_MODEL),)
PRODUCT_MODEL := Snapp Automotive build of Android Automotive OS for VIM3
else
PRODUCT_MODEL := $(SNAPP_MODEL)
endif

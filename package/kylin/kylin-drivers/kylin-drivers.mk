################################################################################
#
# kylin-drivers
#
################################################################################

KYLIN_DRIVERS_VERSION = 0.0.3
KYLIN_DRIVERS_SITE_METHOD = git
KYLIN_DRIVERS_SITE = git@github.com:Metrological/kylin-drivers.git
KYLIN_DRIVERS_INSTALL_STAGING = YES
KYLIN_DRIVERS_DEPENDENCIES += linux

KYLIN_DRIVER_MAKE_ENV = TOP=$(@D) \
                         CROSS=$(TARGET_CROSS) \
                         CROSS_COMPILE=$(TARGET_CROSS) \
                         KERNEL_SRC=${LINUX_DIR} \
                         ARCH=arm64

KYLIN_DRIVER_MALI_MAKE_ENV = $(KYLIN_DRIVER_MAKE_ENV) \
                              MALI_ARCH=arm64 \
                              MALI_CROSS_COMPILE=$(TARGET_CROSS) \
                              TARGET_KDIR=${LINUX_DIR} \
                              KERNEL_PATH=${LINUX_DIR} \
                              KERNEL_VERSION=$(LINUX_VERSION_PROBED) \
                              SOURCE_ROOT_DIR=$(@D)    
                       
KYLIN_RF4CE_DRIVER_MAKE_ENV = $(KYLIN_DRIVER_MAKE_ENV) \
                              GP_CHIP=GP712

KYLIN_PARAGON_DRIVER_MAKE_ENV = $(KYLIN_DRIVER_MAKE_ENV) \
                                KERNEL_TARGET_CHIP=kylin \
                                UFSD_HOST=$(patsubst %-,%,$(TARGET_CROSS))


ifeq ($(BR2_PACKAGE_KYLIN_DRIVERS_MALI),y)
define KYLIN_MALI_DRIVER_BUILD
    $(MAKE) $(KYLIN_DRIVER_MALI_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/gpu/mali build
    $(MAKE) $(KYLIN_DRIVER_MALI_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/gpu/mali strip
endef
define KYLIN_MALI_DRIVER_INSTALL
    $(MAKE) $(KYLIN_DRIVER_MALI_MAKE_ENV) INSTALL_MOD_PATH=${1} $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/gpu/mali install
endef
else
define KYLIN_MALI_DRIVER_BUILD
endef
define KYLIN_MALI_DRIVER_INSTALL
endef
endif


ifeq ($(BR2_PACKAGE_KYLIN_DRIVERS_WIFI),y)
define KYLIN_WIFI_DRIVER_BUILD
    $(MAKE) $(KYLIN_DRIVER_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/wifi all
endef
define KYLIN_WIFI_DRIVER_INSTALL
    $(MAKE) $(KYLIN_DRIVER_MAKE_ENV) INSTALL_MOD_PATH=${1} $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/wifi modules_install
endef
else
define KYLIN_WIFI_DRIVER_BUILD
endef
define KYLIN_WIFI_DRIVER_INSTALL
endef
endif


ifeq ($(BR2_PACKAGE_KYLIN_DRIVERS_BLUETOOTH),y)
define KYLIN_BT_DRIVER_BUILD
    $(MAKE) $(KYLIN_DRIVER_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/bluetooth/rtk_btusb all
    $(MAKE) $(KYLIN_DRIVER_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/bluetooth/rtk_btusb strip
endef
define KYLIN_BT_DRIVER_INSTALL
    $(MAKE) $(KYLIN_DRIVER_MAKE_ENV) INSTALL_MOD_PATH=${1} $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/bluetooth/rtk_btusb modules_install
endef
else
define KYLIN_BT_DRIVER_BUILD
endef
define KYLIN_BT_DRIVER_INSTALL
endef
endif


ifeq ($(BR2_PACKAGE_KYLIN_DRIVERS_RF4CE),y)
define KYLIN_RF4CE_DRIVER_BUILD
    $(MAKE) $(KYLIN_RF4CE_DRIVER_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/rf4ce/gp712_driver all
    $(MAKE) $(KYLIN_RF4CE_DRIVER_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/rf4ce/gp712_driver strip
endef
define KYLIN_RF4CE_DRIVER_INSTALL
    $(MAKE) $(KYLIN_RF4CE_DRIVER_MAKE_ENV) INSTALL_MOD_PATH=${1} $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/rf4ce/gp712_driver modules_install
endef
else
define KYLIN_RF4CE_DRIVER_BUILD
endef
define KYLIN_RF4CE_DRIVER_INSTALL
endef
endif


ifeq ($(BR2_PACKAGE_KYLIN_DRIVERS_PARAGON),y)
define KYLIN_PARAGON_DRIVER_BUILD
    $(MAKE) $(KYLIN_PARAGON_DRIVER_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/paragon all
endef
define KYLIN_PARAGON_DRIVER_INSTALL
    $(MAKE) $(KYLIN_PARAGON_DRIVER_MAKE_ENV) INSTALL_MOD_PATH=${1} $(TARGET_CONFIGURE_OPTS) -C $(@D)/drivers/paragon modules_install
endef
else
define KYLIN_PARAGON_DRIVER_BUILD
endef
define KYLIN_PARAGON_DRIVER_INSTALL
endef
endif

ifeq ($(BR2_PACKAGE_KYLIN_DRIVERS_REALTEK),y)
define KYLIN_REALTEK_DRIVERS_BUILD
    $(MAKE) $(KYLIN_DRIVER_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/osal all
    $(MAKE) $(KYLIN_DRIVER_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D)/platform_lib/ion all
endef
define KYLIN_REALTEK_DRIVERS_INSTALL
  $(INSTALL) -m 0755 -d ${1}/usr/lib 
  $(INSTALL) -m 0755 $(@D)/osal/*.so ${1}/usr/lib
endef
else
define KYLIN_REALTEK_DRIVERS_BUILD
endef
define KYLIN_REALTEK_DRIVERS_INSTALL
endef
endif

ifeq ($(BR2_PACKAGE_KYLIN_DRIVERS_AUDIO),y)
define KYLIN_AUDIO_DRIVERS_INSTALL
  $(INSTALL) -m 0755 $(@D)/drivers/audio/bluecore.audio ${BINARIES_DIR}/bluecore.audio
endef
else
define KYLIN_AUDIO_DRIVERS_INSTALL
endef
endif

ifeq ($(BR2_PACKAGE_KYLIN_RESCUE_IMG),y)
define KYLIN_RESCUE_IMG_INSTALL
  $(INSTALL) -m 0755 $(@D)/rescue/rescue.root.emmc.cpio.gz_pad.img  ${BINARIES_DIR}/rescue.root.emmc.cpio.gz_pad.img
endef
else
define KYLIN_RESCUE_IMG_INSTALL
endef
endif

define KYLIN_DRIVERS_BUILD_CMDS
    $(call KYLIN_MALI_DRIVER_BUILD)
    $(call KYLIN_WIFI_DRIVER_BUILD)
    $(call KYLIN_BT_DRIVER_BUILD)
    $(call KYLIN_RF4CE_DRIVER_BUILD)
    $(call KYLIN_PARAGON_DRIVER_BUILD)
    $(call KYLIN_REALTEK_DRIVERS_BUILD)
endef

define KYLIN_DRIVERS_INSTALL_STAGING_CMDS
    $(call KYLIN_MALI_DRIVER_INSTALL,${STAGING_DIR})
    $(call KYLIN_WIFI_DRIVER_INSTALL,${STAGING_DIR})
    $(call KYLIN_BT_DRIVER_INSTALL,${STAGING_DIR})
    $(call KYLIN_RF4CE_DRIVER_INSTALL,${STAGING_DIR})
    $(call KYLIN_PARAGON_DRIVER_INSTALL,${STAGING_DIR})
    $(call KYLIN_REALTEK_DRIVERS_INSTALL,${STAGING_DIR})
endef

define KYLIN_DRIVERS_INSTALL_TARGET_CMDS
    $(call KYLIN_MALI_DRIVER_INSTALL,${TARGET_DIR})
    $(call KYLIN_WIFI_DRIVER_INSTALL,${TARGET_DIR})
    $(call KYLIN_BT_DRIVER_INSTALL,${TARGET_DIR})
    $(call KYLIN_RF4CE_DRIVER_INSTALL,${TARGET_DIR})
    $(call KYLIN_PARAGON_DRIVER_INSTALL,${TARGET_DIR})
    $(call KYLIN_REALTEK_DRIVERS_INSTALL,${TARGET_DIR})
endef

KYLIN_DRIVERS_POST_BUILD_HOOKS += KYLIN_AUDIO_DRIVERS_INSTALL
KYLIN_DRIVERS_POST_BUILD_HOOKS += KYLIN_RESCUE_IMG_INSTALL

$(eval $(generic-package))



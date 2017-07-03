################################################################################
#
# kylin-apps
#
################################################################################

KYLIN_APPS_VERSION = 0.0.0
KYLIN_APPS_SITE = 
KYLIN_APPS_SOURCE = 
KYLIN_APPS_INSTALL_STAGING = YES
KYLIN_APPS_INSTALL_TARGET = YES

KYLIN_APPS_CONF_OPTS += -DPLATFORM_LIB_INCLUDE_DIR=$(STAGING_DIR)/usr/include/realtek
KYLIN_APPS_CONF_OPTS += -DPLATFORM_LIB_LIB_DIR=$(STAGING_DIR)/usr/lib

ifeq ($(BR2_PACKAGE_KYLIN_HDMI_INFO),y)
KYLIN_APPS_DEPENDENCIES += udev kylin-platform-lib kylin-graphics
KYLIN_APPS_CONF_OPTS += -DENABLE_KYLIN_HDMI_INFO=ON
else
KYLIN_APPS_CONF_OPTS += -DENABLE_KYLIN_HDMI_INFO=OFF
endif

ifeq ($(BR2_PACKAGE_KYLIN_HDMI_MODESET),y)
KYLIN_APPS_DEPENDENCIES += udev kylin-platform-lib kylin-graphics
KYLIN_APPS_CONF_OPTS += -DENABLE_KYLIN_HDMI_MODESET=ON
else
KYLIN_APPS_CONF_OPTS += -DENABLE_KYLIN_HDMI_MODESET=OFF
endif

ifeq ($(BR2_PACKAGE_KYLIN_SIMPLE_APP),y)
KYLIN_APPS_DEPENDENCIES += udev kylin-platform-lib kylin-graphics
KYLIN_APPS_CONF_OPTS += -DENABLE_KYLIN_SIMPLE_APP=ON
else
KYLIN_APPS_CONF_OPTS += -DENABLE_KYLIN_SIMPLE_APP=OFF
endif

ifeq ($(BR2_PACKAGE_KYLIN_VIDEO_INFO),y)
KYLIN_APPS_DEPENDENCIES += udev kylin-platform-lib kylin-graphics
KYLIN_APPS_CONF_OPTS += -DENABLE_KYLIN_VIDEO_INFO=ON
else
KYLIN_APPS_CONF_OPTS += -DENABLE_KYLIN_VIDEO_INFO=OFF
endif

$(eval $(cmake-package))

################################################################################
#
# kylin-tools
#
################################################################################

KYLIN_TOOLS_VERSION = 35c68e79600909f88a23b79fdc7fd87f6b1b206b
KYLIN_TOOLS_SITE_METHOD = git
KYLIN_TOOLS_SITE = git@github.com:Metrological/kylin-tools.git
KYLIN_TOOLS_INSTALL_STAGING = YES
KYLIN_TOOLS_DEPENDENCIES += kylin-platform-lib

ifeq ($(BR2_PACKAGE_KYLIN_TOOLS_DISPLAY),y)
KYLIN_TOOLS_CONF_OPTS += -DKYLIN_TOOLS_DISPLAY=ON
endif

$(eval $(cmake-package))

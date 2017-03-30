################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 9ebb6f854a603625b25535383cff9928f42edbc1
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl WPEFramework

$(eval $(cmake-package))

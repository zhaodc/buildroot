################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 9691b3c03b1837cc683719c2913cbe4304b3892c
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl WPEFramework

$(eval $(cmake-package))

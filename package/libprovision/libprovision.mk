################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = fd4a99db033cc69ab20b6c07f70478ae8e9b97f5
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl WPEFramework

$(eval $(cmake-package))

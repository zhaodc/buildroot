################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 0822c06193c0bf8d815781fe37cda1cba1df1740
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl

$(eval $(cmake-package))

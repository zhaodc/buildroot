################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 8cf8ba80a5b939afe56731ffa92adb3b117949de
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl WPEFramework

$(eval $(cmake-package))

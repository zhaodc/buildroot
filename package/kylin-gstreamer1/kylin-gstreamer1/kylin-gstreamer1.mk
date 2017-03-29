################################################################################
#
# KYLIN_GSTREAMER1
#
################################################################################

KYLIN_GSTREAMER1_VERSION = 1.8.3
KYLIN_GSTREAMER1_SOURCE = gstreamer-$(KYLIN_GSTREAMER1_VERSION).tar.xz
KYLIN_GSTREAMER1_SITE = https://gstreamer.freedesktop.org/src/gstreamer
KYLIN_GSTREAMER1_INSTALL_STAGING = YES
KYLIN_GSTREAMER1_LICENSE_FILES = COPYING
KYLIN_GSTREAMER1_LICENSE = LGPLv2+, LGPLv2.1+

# Checking if unaligned memory access works correctly cannot be done when cross
# compiling. For the following architectures there is no information available
# in the configure script.
ifeq ($(BR2_arc)$(BR2_xtensa)$(BR2_microblaze)$(BR2_nios2),y)
KYLIN_GSTREAMER1_CONF_ENV = as_cv_unaligned_access=no
endif
ifeq ($(BR2_aarch64),y)
KYLIN_GSTREAMER1_CONF_ENV = as_cv_unaligned_access=yes
endif

KYLIN_GSTREAMER1_CONF_OPTS = \
	--disable-examples \
	--disable-tests \
	--disable-failing-tests \
	--disable-valgrind \
	--disable-benchmarks \
	--disable-check \
	$(if $(BR2_PACKAGE_KYLIN_GSTREAMER1_TRACE),,--disable-trace) \
	$(if $(BR2_PACKAGE_KYLIN_GSTREAMER1_PARSE),,--disable-parse) \
	$(if $(BR2_PACKAGE_KYLIN_GSTREAMER1_GST_DEBUG),,--disable-gst-debug) \
	$(if $(BR2_PACKAGE_KYLIN_GSTREAMER1_PLUGIN_REGISTRY),,--disable-registry) \
	$(if $(BR2_PACKAGE_KYLIN_GSTREAMER1_INSTALL_TOOLS),,--disable-tools)

KYLIN_GSTREAMER1_DEPENDENCIES = libglib2 host-pkgconf host-bison host-flex

# gstreamer-1.6 changed the location of its gstconfig.h file,
# and unfortunately, not all (by far!) consumers have been
# updated to look in the correct location.
# Add a symlink to the legacy location
define KYLIN_GSTREAMER1_LEGACY_CGSTCONFIG_H
	cd $(STAGING_DIR)/usr/include/gstreamer-1.0/gst && \
		ln -sf ../../../lib/gstreamer-1.0/include/gst/gstconfig.h .
endef
KYLIN_GSTREAMER1_POST_INSTALL_STAGING_HOOKS += KYLIN_GSTREAMER1_LEGACY_CGSTCONFIG_H

$(eval $(autotools-package))

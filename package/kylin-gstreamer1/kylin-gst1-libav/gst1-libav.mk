################################################################################
#
# kylin-gst1-libav
#
################################################################################

KYLIN_GST1_LIBAV_VERSION = 1.10.4
KYLIN_GST1_LIBAV_SOURCE = gst-libav-$(KYLIN_GST1_LIBAV_VERSION).tar.xz
KYLIN_GST1_LIBAV_SITE = https://gstreamer.freedesktop.org/src/gst-libav
KYLIN_GST1_LIBAV_CONF_OPTS = --with-system-libav
KYLIN_GST1_LIBAV_DEPENDENCIES = \
	host-pkgconf ffmpeg kylin-gstreamer1 kylin-gst1-plugins-base \
	$(if $(BR2_PACKAGE_BZIP2),bzip2) \
	$(if $(BR2_PACKAGE_XZ),xz)
KYLIN_GST1_LIBAV_LICENSE = GPLv2+
KYLIN_GST1_LIBAV_LICENSE_FILES = COPYING

$(eval $(autotools-package))

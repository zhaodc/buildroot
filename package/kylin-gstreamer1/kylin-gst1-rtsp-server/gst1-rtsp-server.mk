################################################################################
#
# kylin-gst1-rtsp-server
#
################################################################################

KYLIN_GST1_RTSP_SERVER_VERSION = 1.10.4
KYLIN_GST1_RTSP_SERVER_SOURCE = gst-rtsp-server-$(KYLIN_GST1_RTSP_SERVER_VERSION).tar.xz
KYLIN_GST1_RTSP_SERVER_SITE = http://gstreamer.freedesktop.org/src/gst-rtsp-server
KYLIN_GST1_RTSP_SERVER_LICENSE = LGPLv2+
KYLIN_GST1_RTSP_SERVER_LICENSE_FILES = COPYING COPYING.LIB
KYLIN_GST1_RTSP_SERVER_INSTALL_STAGING = YES
KYLIN_GST1_RTSP_SERVER_DEPENDENCIES = \
	host-pkgconf \
	kylin-gstreamer1 \
	kylin-gst1-plugins-base \
	kylin-gst1-plugins-good

ifeq ($(BR2_PACKAGE_LIBCGROUP),y)
KYLIN_GST1_RTSP_SERVER_DEPENDENCIES += libcgroup
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BAD),y)
KYLIN_GST1_RTSP_SERVER_DEPENDENCIES += kylin-gst1-plugins-bad
endif

$(eval $(autotools-package))

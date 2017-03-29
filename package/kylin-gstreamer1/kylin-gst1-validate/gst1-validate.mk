################################################################################
#
# kylin-gst1-validate
#
################################################################################

KYLIN_GST1_VALIDATE_VERSION = 1.10.4
KYLIN_GST1_VALIDATE_SOURCE = gst-validate-$(KYLIN_GST1_VALIDATE_VERSION).tar.xz
KYLIN_GST1_VALIDATE_SITE = https://gstreamer.freedesktop.org/src/gst-validate
KYLIN_GST1_VALIDATE_LICENSE = LGPLv2.1+
KYLIN_GST1_VALIDATE_LICENSE_FILES = COPYING

KYLIN_GST1_VALIDATE_CONF_OPTS = --disable-sphinx-doc

KYLIN_GST1_VALIDATE_DEPENDENCIES = \
	kylin-gstreamer1 \
	kylin-gst1-plugins-base \
	json-glib \
	host-python \
	python \
	$(if $(BR2_PACKAGE_CAIRO),cairo)

$(eval $(autotools-package))

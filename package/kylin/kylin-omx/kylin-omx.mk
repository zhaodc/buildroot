################################################################################
#
# kylin-omx
#
################################################################################

KYLIN_OMX_VERSION = 0.0.1
KYLIN_OMX_SITE = package/kylin/kylin-omx
KYLIN_OMX_SITE_METHOD = local

KYLIN_OMX_PROVIDES = libopenmax

define KYLIN_OMX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/gstomx.conf \
		$(TARGET_DIR)/etc/xdg/gstomx.conf
	$(INSTALL) -D -m 0644 $(@D)/gst-openmax.conf \
		$(TARGET_DIR)/etc/xdg/gstreamer-0.10/gst-openmax.conf
endef

$(eval $(generic-package))

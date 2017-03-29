################################################################################
#
# phoenix-omx
#
################################################################################

PHOENIX_OMX_VERSION = 0.0.1
PHOENIX_OMX_SITE = package/phoenix-omx
PHOENIX_OMX_SITE_METHOD = local

PHOENIX_OMX_PROVIDES = libopenmax

define PHOENIX_OMX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/gstomx.conf \
		$(TARGET_DIR)/etc/xdg/gstomx.conf
	$(INSTALL) -D -m 0644 $(@D)/gst-openmax.conf \
		$(TARGET_DIR)/etc/xdg/gstreamer-0.10/gst-openmax.conf
endef

$(eval $(generic-package))

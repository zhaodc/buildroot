################################################################################
#
# kylin-gst-rtkv1sink
#
################################################################################

KYLIN_GST_RTKV1SINK_VERSION = fc21beb1798b013fad513257b7248c27c2342a0f
KYLIN_GST_RTKV1SINK_SITE_METHOD = git
KYLIN_GST_RTKV1SINK_SITE = git@github.com:Metrological/kylin-GST_RTKV1SINK.git
KYLIN_GST_RTKV1SINK_INSTALL_STAGING = YES

KYLIN_GST_RTKV1SINK_DEPENDENCIES = kylin-gstreamer1 kylin-gst1-plugins-base kylin-gst-omx kylin-platform-lib

define KYLIN_GST_RTKV1SINK_BUILD_CMDS
	echo Building from $(@D)/src
	make -C $(@D)/src STAGING_DIR=$(STAGING_DIR) HOST_DIR=$(HOST_DIR) TARGET_CC=$(TARGET_CC) TARGET_LD=$(TARGET_LD)
endef

define KYLIN_GST_RTKV1SINK_INSTALL_STAGING_CMDS
    $(call KYLIN_GST_RTKV1SINK_INSTALL_LIBS,$(STAGING_DIR))
endef

define KYLIN_GST_RTKV1SINK_INSTALL_TARGET_CMDS
    $(call KYLIN_GST_RTKV1SINK_INSTALL_LIBS,$(TARGET_DIR))
endef

define KYLIN_GST_RTKV1SINK_INSTALL_LIBS
  $(INSTALL) -d -m 0755 $(1)/usr/lib/gstreamer-1.0
  $(INSTALL) -m 0755 $(@D)/usr/lib/gstreamer-1.0/*.so ${1}/usr/lib/gstreamer-1.0
endef

$(eval $(generic-package))

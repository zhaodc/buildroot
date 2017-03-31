################################################################################
#
# kylin-gst-omx
#
################################################################################

KYLIN_GST_OMX_VERSION = e69f705c1cde2ef2b3f7f593b9741da3be3d6259
KYLIN_GST_OMX_SITE_METHOD = git
KYLIN_GST_OMX_SITE = git@github.com:Metrological/kylin-gst-omx.git

KYLIN_GST_OMX_LICENSE = LGPLv2.1
KYLIN_GST_OMX_LICENSE_FILES = COPYING

KYLIN_GST_OMX_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_KYLIN_OMX),y)
KYLIN_GST_OMX_CONF_OPTS = \
	--with-omx-target=generic --with-omx-header-path=$(@D)/omx/openmax
KYLIN_GST_OMX_CONF_ENV = \
    CFLAGS="-I$(STAGING_DIR)/usr/include/realtek/genericLinux/include"
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
KYLIN_GST_OMX_CONF_OPTS = \
	--with-omx-target=rpi
KYLIN_GST_OMX_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) \
		-I$(STAGING_DIR)/usr/include/IL \
		-I$(STAGING_DIR)/usr/include/interface/vcos/pthreads \
		-I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux"
endif

ifeq ($(BR2_PACKAGE_BELLAGIO),y)
KYLIN_GST_OMX_CONF_OPTS = \
	--with-omx-target=bellagio
KYLIN_GST_OMX_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) \
		-DOMX_VERSION_MAJOR=1 \
		-DOMX_VERSION_MINOR=1 \
		-DOMX_VERSION_REVISION=2 \
		-DOMX_VERSION_STEP=0"
endif

ifeq ($(BR2_PACKAGE_KYLIN_OMX),y)
KYLIN_GST_OMX_DEPENDENCIES = kylin-gstreamer1 kylin-gst1-plugins-base libopenmax kylin-platform-lib
else
KYLIN_GST_OMX_DEPENDENCIES = kylin-gstreamer1 kylin-gst1-plugins-base libopenmax
endif

# adjust library paths to where buildroot installs them
define KYLIN_GST_OMX_FIXUP_CONFIG_PATHS
	find $(@D)/config -name gstomx.conf | \
		xargs $(SED) 's|/usr/local|/usr|g' -e 's|/opt/vc|/usr|g'
endef

KYLIN_GST_OMX_POST_PATCH_HOOKS += KYLIN_GST_OMX_FIXUP_CONFIG_PATHS

define KYLIN_GST_OMX_POST_INSTALL_HEADERS
    $(INSTALL) -m 0755 -d $(STAGING_DIR)/usr/include/gstreamer-1.0/gstomx
    cp -arf $(@D)/omx/*.h $(STAGING_DIR)/usr/include/gstreamer-1.0/gstomx
    $(INSTALL) -m 0755 -d $(STAGING_DIR)/usr/include/gstreamer-1.0/gstomx/openmax
    cp -arf $(@D)/omx/openmax/*.h $(STAGING_DIR)/usr/include/gstreamer-1.0/gstomx/openmax
endef

KYLIN_GST_OMX_POST_INSTALL_TARGET_HOOKS += KYLIN_GST_OMX_POST_INSTALL_HEADERS

$(eval $(autotools-package))

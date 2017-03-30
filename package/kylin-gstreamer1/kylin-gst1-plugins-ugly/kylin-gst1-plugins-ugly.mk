################################################################################
#
# gst1-plugins-ugly
#
################################################################################

KYLIN_GST1_PLUGINS_UGLY_VERSION = 1.8.3
KYLIN_GST1_PLUGINS_UGLY_SOURCE = gst-plugins-ugly-$(KYLIN_GST1_PLUGINS_UGLY_VERSION).tar.xz
KYLIN_GST1_PLUGINS_UGLY_SITE = https://gstreamer.freedesktop.org/src/gst-plugins-ugly
KYLIN_GST1_PLUGINS_UGLY_LICENSE_FILES = COPYING
# GPL licensed plugins will append to KYLIN_GST1_PLUGINS_UGLY_LICENSE if enabled.
KYLIN_GST1_PLUGINS_UGLY_LICENSE = LGPLv2.1+

KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS = --disable-examples --disable-valgrind

KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += \
	--disable-a52dec \
	--disable-amrnb \
	--disable-amrwb \
	--disable-cdio \
	--disable-sidplay \
	--disable-twolame

KYLIN_GST1_PLUGINS_UGLY_DEPENDENCIES = kylin-gstreamer1 kylin-gst1-plugins-base

ifeq ($(BR2_PACKAGE_ORC),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-orc
KYLIN_GST1_PLUGINS_UGLY_DEPENDENCIES += orc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_ASFDEMUX),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-asfdemux
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-asfdemux
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_DVDLPCMDEC),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-dvdlpcmdec
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-dvdlpcmdec
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_DVDSUB),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-dvdsub
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-dvdsub
endif

ifeq ($(BR2_PACKAGE_GST_PLUGINS_UGLY_PLUGIN_XINGMUX),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-xingmux
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-xingmux
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_REALMEDIA),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-realmedia
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-realmedia
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_DVDREAD),y)
# configure does not use pkg-config to detect libdvdread
ifeq ($(BR2_PACKAGE_LIBDVDCSS)$(BR2_STATIC_LIBS),yy)
KYLIN_GST1_PLUGINS_UGLY_CONF_ENV += LIBS="-ldvdcss"
endif
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-dvdread
KYLIN_GST1_PLUGINS_UGLY_DEPENDENCIES += libdvdread
KYLIN_GST1_PLUGINS_UGLY_HAS_GPL_LICENSE = y
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-dvdread
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_LAME),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-lame
KYLIN_GST1_PLUGINS_UGLY_DEPENDENCIES += lame
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-lame
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_MAD),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-mad
KYLIN_GST1_PLUGINS_UGLY_DEPENDENCIES += libid3tag libmad
KYLIN_GST1_PLUGINS_UGLY_HAS_GPL_LICENSE = y
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-mad
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_MPG123),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-mpg123
KYLIN_GST1_PLUGINS_UGLY_DEPENDENCIES += mpg123
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-mpg123
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_MPEG2DEC),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-mpeg2dec
KYLIN_GST1_PLUGINS_UGLY_DEPENDENCIES += libmpeg2
GST1_PLUGINS_ULGY_HAS_GPL_LICENSE = y
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-mpeg2dec
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_UGLY_PLUGIN_X264),y)
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --enable-x264
KYLIN_GST1_PLUGINS_UGLY_DEPENDENCIES += x264
KYLIN_GST1_PLUGINS_UGLY_HAS_GPL_LICENSE = y
else
KYLIN_GST1_PLUGINS_UGLY_CONF_OPTS += --disable-x264
endif

# Add GPL license if GPL plugins enabled.
ifeq ($(KYLIN_GST1_PLUGINS_UGLY_HAS_GPL_LICENSE),y)
KYLIN_GST1_PLUGINS_UGLY_LICENSE += GPLv2
endif

# Use the following command to extract license info for plugins.
# # find . -name 'plugin-*.xml' | xargs grep license

$(eval $(autotools-package))

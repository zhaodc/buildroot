################################################################################
#
# gst1-plugins-base
#
################################################################################

KYLIN_GST1_PLUGINS_BASE_VERSION = 1.8.3
KYLIN_GST1_PLUGINS_BASE_SOURCE = gst-plugins-base-$(KYLIN_GST1_PLUGINS_BASE_VERSION).tar.xz
KYLIN_GST1_PLUGINS_BASE_SITE = https://gstreamer.freedesktop.org/src/gst-plugins-base
KYLIN_GST1_PLUGINS_BASE_INSTALL_STAGING = YES
KYLIN_GST1_PLUGINS_BASE_LICENSE_FILES = COPYING.LIB
KYLIN_GST1_PLUGINS_BASE_LICENSE = LGPLv2+, LGPLv2.1+

# freetype is only used by examples, but if it is not found
# and the host has a freetype-config script, then the host
# include dirs are added to the search path causing trouble
KYLIN_GST1_PLUGINS_BASE_CONF_ENV =
	FT2_CONFIG=/bin/false \
	ac_cv_header_stdint_t="stdint.h"

# gio_unix_2_0 is only used for tests
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS = \
	--disable-examples \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-gio_unix_2_0 \
	--disable-freetypetest \
	--disable-valgrind

# Options which require currently unpackaged libraries
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += \
	--disable-cdparanoia \
	--disable-libvisual \
	--disable-iso-codes

KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES = kylin-gstreamer1

# These plugins are liste in the order from ./configure --help

ifeq ($(BR2_PACKAGE_ORC),y)
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += orc
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-orc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_ADDER),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-adder
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-adder
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_APP),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-app
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-app
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_AUDIOCONVERT),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-audioconvert
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-audioconvert
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_AUDIORATE),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-audiorate
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-audiorate
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_AUDIOTESTSRC),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-audiotestsrc
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-audiotestsrc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_ENCODING),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-encoding
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-encoding
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_VIDEOCONVERT),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-videoconvert
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-videoconvert
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_GIO),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-gio
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-gio
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_PLAYBACK),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-playback
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-playback
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_AUDIORESAMPLE),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-audioresample
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-audioresample
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_SUBPARSE),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-subparse
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-subparse
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_TCP),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-tcp
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-tcp
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_TYPEFIND),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-typefind
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-typefind
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_VIDEOTESTSRC),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-videotestsrc
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-videotestsrc
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_VIDEORATE),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-videorate
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-videorate
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_VIDEOSCALE),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-videoscale
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-videoscale
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_VOLUME),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-volume
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-volume
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += zlib
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += xlib_libX11 xlib_libXext xlib_libXv
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += \
	--enable-x \
	--enable-xshm \
	--enable-xvideo
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += \
	--disable-x \
	--disable-xshm \
	--disable-xvideo
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_ALSA),y)
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += alsa-lib
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-alsa
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_TREMOR),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-ivorbis
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += tremor
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-ivorbis
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_OPUS),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-opus
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += opus
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-opus
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_OGG),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-ogg
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += libogg
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-ogg
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_PANGO),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-pango
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += pango
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-pango
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_THEORA),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-theora
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += libtheora
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-theora
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_PLUGINS_BASE_PLUGIN_VORBIS),y)
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --enable-vorbis
KYLIN_GST1_PLUGINS_BASE_DEPENDENCIES += libvorbis
else
KYLIN_GST1_PLUGINS_BASE_CONF_OPTS += --disable-vorbis
endif

$(eval $(autotools-package))

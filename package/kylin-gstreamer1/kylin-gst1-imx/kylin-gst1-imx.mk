################################################################################
#
# kylin-gst1-imx
#
################################################################################

KYLIN_GST1_IMX_VERSION = 0.12.3
KYLIN_GST1_IMX_SITE = $(call github,Freescale,gstreamer-imx,$(KYLIN_GST1_IMX_VERSION))

KYLIN_GST1_IMX_LICENSE = LGPLv2+
KYLIN_GST1_IMX_LICENSE_FILES = LICENSE

KYLIN_GST1_IMX_INSTALL_STAGING = YES

KYLIN_GST1_IMX_DEPENDENCIES += \
	host-pkgconf \
	kylin-gstreamer1 \
	kylin-gst1-plugins-base

KYLIN_GST1_IMX_CONF_OPTS = --prefix="/usr"

ifeq ($(BR2_LINUX_KERNEL),y)
# IPU and PXP need access to imx-specific kernel headers
KYLIN_GST1_IMX_DEPENDENCIES += linux
KYLIN_GST1_IMX_CONF_OPTS += --kernel-headers="$(LINUX_DIR)/include"
endif

ifeq ($(BR2_PACKAGE_IMX_CODEC),y)
KYLIN_GST1_IMX_DEPENDENCIES += imx-codec
endif

ifeq ($(BR2_PACKAGE_IMX_GPU_VIV),y)
KYLIN_GST1_IMX_DEPENDENCIES += imx-gpu-viv
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_IMX_EGLVISINK),y)
# There's no --enable-eglvivsink option
ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
KYLIN_GST1_IMX_DEPENDENCIES += xlib_libX11
KYLIN_GST1_IMX_CONF_OPTS += --egl-platform=x11
else
ifeq ($(BR2_PACKAGE_WAYLAND),y)
KYLIN_GST1_IMX_DEPENDENCIES += wayland
KYLIN_GST1_IMX_CONF_OPTS += --egl-platform=wayland
else
KYLIN_GST1_IMX_CONF_OPTS += --egl-platform=fb
endif
endif
else
KYLIN_GST1_IMX_CONF_OPTS += --disable-eglvivsink
endif

# There's no --enable-g2d option
ifeq ($(BR2_PACKAGE_KYLIN_GST1_IMX_G2D),)
KYLIN_GST1_IMX_CONF_OPTS += --disable-g2d
endif

# There's no --enable-ipu option
ifeq ($(BR2_PACKAGE_KYLIN_GST1_IMX_IPU),)
KYLIN_GST1_IMX_CONF_OPTS += --disable-ipu
endif

# There's no --enable-mp3encoder option
ifeq ($(BR2_PACKAGE_KYLIN_GST1_IMX_MP3ENCODER),)
KYLIN_GST1_IMX_CONF_OPTS += --disable-mp3encoder
endif

# There's no --enable-pxp option
ifeq ($(BR2_PACKAGE_KYLIN_GST1_IMX_PXP),)
KYLIN_GST1_IMX_CONF_OPTS += --disable-pxp
endif

# There's no --enable-uniaudiodec option
ifeq ($(BR2_PACKAGE_KYLIN_GST1_IMX_UNIAUDIODEC),)
KYLIN_GST1_IMX_CONF_OPTS += --disable-uniaudiodec
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_IMX_VPU),y)
# There's no --enable-vpu option
KYLIN_GST1_IMX_DEPENDENCIES += libimxvpuapi
else
KYLIN_GST1_IMX_CONF_OPTS += --disable-vpu
endif

ifeq ($(BR2_PACKAGE_KYLIN_GST1_IMX_V4L2VIDEOSRC),y)
# There's no --enable-v4l2src option
KYLIN_GST1_IMX_DEPENDENCIES += kylin-gst1-plugins-bad
else
KYLIN_GST1_IMX_CONF_OPTS += --disable-v4l2src
endif

$(eval $(waf-package))

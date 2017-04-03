################################################################################
#
# kylin-weston
#
################################################################################

KYLIN_WESTON_VERSION = 1.12.0
KYLIN_WESTON_SITE = http://wayland.freedesktop.org/releases
KYLIN_WESTON_SOURCE = weston-$(KYLIN_WESTON_VERSION).tar.xz
KYLIN_WESTON_LICENSE = MIT
KYLIN_WESTON_LICENSE_FILES = COPYING

KYLIN_WESTON_DEPENDENCIES = host-pkgconf wayland wayland-protocols \
	libxkbcommon pixman libpng jpeg mtdev udev cairo libinput \
	$(if $(BR2_PACKAGE_WEBP),webp)

KYLIN_WESTON_CONF_OPTS = \
	--with-dtddir=$(STAGING_DIR)/usr/share/wayland \
	--disable-headless-compositor \
	--disable-colord \
	--disable-devdocs \
	--disable-setuid-install

KYLIN_WESTON_MAKE_OPTS = \
	WAYLAND_PROTOCOLS_DATADIR=$(STAGING_DIR)/usr/share/wayland-protocols

# Uses VIDIOC_EXPBUF, only available from 3.8+
ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_8),)
KYLIN_WESTON_CONF_OPTS += --disable-simple-dmabuf-v4l-client
endif

ifeq ($(BR2_PACKAGE_DBUS),y)
KYLIN_WESTON_CONF_OPTS += --enable-dbus
KYLIN_WESTON_DEPENDENCIES += dbus
else
KYLIN_WESTON_CONF_OPTS += --disable-dbus
endif

# weston-launch must be u+s root in order to work properly
ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
define KYLIN_WESTON_PERMISSIONS
	/usr/bin/weston-launch f 4755 0 0 - - - - -
endef
define KYLIN_WESTON_USERS
	- - weston-launch -1 - - - - Weston launcher group
endef
KYLIN_WESTON_CONF_OPTS += --enable-weston-launch
KYLIN_WESTON_DEPENDENCIES += linux-pam
else
KYLIN_WESTON_CONF_OPTS += --disable-weston-launch
endif

# Needs wayland-egl, which normally only mesa provides
ifeq ($(BR2_PACKAGE_MESA3D_OPENGL_EGL)$(BR2_PACKAGE_MESA3D_OPENGL_ES),yy)
KYLIN_WESTON_CONF_OPTS += --enable-egl
KYLIN_WESTON_DEPENDENCIES += libegl

# Needs wayland-egl, provided by mali
else ifeq ($(BR2_PACKAGE_KYLIN_GRAPHICS),y)
KYLIN_WESTON_CONF_OPTS += --enable-egl \
                    --enable-simple-egl-clients
KYLIN_WESTON_DEPENDENCIES += libegl
KYLIN_WESTON_CONF_ENV += \
       EGL_CFLAGS="-DEGL_FBDEV=1 -I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/GLES2" \
       EGL_LIBS="-L$(STAGING_DIR)/usr/lib/server -lEGL -lGLESv2 -lmali" \
       EGL_TESTS_LIBS="-L$(STAGING_DIR)/usr/lib -lEGL -lGLESv2 -lmali" \
       EGL_TESTS_CFLAGS="-I$(STAGING_DIR)/usr/include" \
       GL_RENDERER_CFLAGS="-I$(STAGING_DIR)/usr/include/drm" \
       GL_RENDERER_LIBS="-L$(STAGING_DIR)/usr/lib -lEGL -lGLESv2 -lmali"
       
else
KYLIN_WESTON_CONF_OPTS += \
	--disable-egl \
	--disable-simple-egl-clients
endif

ifeq ($(BR2_PACKAGE_LIBUNWIND),y)
KYLIN_WESTON_DEPENDENCIES += libunwind
else
KYLIN_WESTON_CONF_OPTS += --disable-libunwind
endif

ifeq ($(BR2_PACKAGE_KYLIN_WESTON_RDP),y)
KYLIN_WESTON_DEPENDENCIES += freerdp
KYLIN_WESTON_CONF_OPTS += --enable-rdp-compositor
else
KYLIN_WESTON_CONF_OPTS += --disable-rdp-compositor
endif

ifeq ($(BR2_PACKAGE_KYLIN_WESTON_FBDEV),y)
KYLIN_WESTON_CONF_OPTS += \
	--enable-fbdev-compositor \
	WESTON_NATIVE_BACKEND=fbdev-backend.so
else
KYLIN_WESTON_CONF_OPTS += --disable-fbdev-compositor
endif

ifeq ($(BR2_PACKAGE_KYLIN_WESTON_DRM),y)
KYLIN_WESTON_CONF_OPTS += \
	--enable-drm-compositor \
	WESTON_NATIVE_BACKEND=drm-backend.so
KYLIN_WESTON_DEPENDENCIES += libdrm
else
KYLIN_WESTON_CONF_OPTS += --disable-drm-compositor
endif

ifeq ($(BR2_PACKAGE_KYLIN_WESTON_X11),y)
KYLIN_WESTON_CONF_OPTS += \
	--enable-x11-compositor \
	WESTON_NATIVE_BACKEND=x11-backend.so
KYLIN_WESTON_DEPENDENCIES += libxcb xlib_libX11
else
KYLIN_WESTON_CONF_OPTS += --disable-x11-compositor
endif

ifeq ($(BR2_PACKAGE_KYLIN_WESTON_XWAYLAND),y)
KYLIN_WESTON_CONF_OPTS += --enable-xwayland
KYLIN_WESTON_DEPENDENCIES += cairo libepoxy libxcb xlib_libX11 xlib_libXcursor
else
KYLIN_WESTON_CONF_OPTS += --disable-xwayland
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
KYLIN_WESTON_CONF_OPTS += --enable-vaapi-recorder
KYLIN_WESTON_DEPENDENCIES += libva
else
KYLIN_WESTON_CONF_OPTS += --disable-vaapi-recorder
endif

ifeq ($(BR2_PACKAGE_LCMS2),y)
KYLIN_WESTON_CONF_OPTS += --enable-lcms
KYLIN_WESTON_DEPENDENCIES += lcms2
else
KYLIN_WESTON_CONF_OPTS += --disable-lcms
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
KYLIN_WESTON_CONF_OPTS += --enable-systemd-login --enable-systemd-notify
KYLIN_WESTON_DEPENDENCIES += systemd
else
KYLIN_WESTON_CONF_OPTS += --disable-systemd-login --disable-systemd-notify
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
KYLIN_WESTON_CONF_OPTS += --enable-junit-xml
KYLIN_WESTON_DEPENDENCIES += libxml2
else
KYLIN_WESTON_CONF_OPTS += --disable-junit-xml
endif

ifeq ($(BR2_PACKAGE_KYLIN_WESTON_DEMO_CLIENTS),y)
KYLIN_WESTON_CONF_OPTS += --enable-demo-clients-install
else
KYLIN_WESTON_CONF_OPTS += --disable-demo-clients-install
endif

$(eval $(autotools-package))

################################################################################
#
# kylin-platform-lib
#
################################################################################

KYLIN_PLATFORM_LIB_VERSION = 1b918c1ce262844d053f56f06ad750ff0286bf01
KYLIN_PLATFORM_LIB_SITE_METHOD = git
KYLIN_PLATFORM_LIB_SITE = git@github.com:Metrological/kylin-platform-lib.git
KYLIN_PLATFORM_LIB_INSTALL_STAGING = YES
KYLIN_PLATFORM_LIB_DEPENDENCIES += wayland

define KYLIN_PLATFORM_LIB_BUILD_CMDS
    @echo  'Nothing to build - Precompiled Binaries.'
endef

define KYLIN_PLATFORM_LIB_INSTALL_STAGING_CMDS
    $(call KYLIN_PLATFORM_LIB_INSTALL_LIBS,$(STAGING_DIR))
	$(call KYLIN_PLATFORM_LIB_INSTALL_HEADERS,$(STAGING_DIR))
	$(call KYLIN_PLATFORM_LIB_INSTALL_ARCHIVES,$(STAGING_DIR))
	$(call KYLIN_PLATFORM_LIB_INSTALL_PKGCNF,$(STAGING_DIR))
endef

define KYLIN_PLATFORM_LIB_INSTALL_TARGET_CMDS
	$(call KYLIN_PLATFORM_LIB_INSTALL_LIBS,$(TARGET_DIR))
	$(call KYLIN_PLATFORM_LIB_INSTALL_MISC_BINARIES,$(TARGET_DIR))
	$(call KYLIN_PLATFORM_LIB_INSTALL_KERNEL_MODULES,$(TARGET_DIR))
endef

################################################################################

define KYLIN_PLATFORM_LIB_INSTALL_LIBS
  $(INSTALL) -m 0755 -d ${1}/usr/lib/realtek 
  $(INSTALL) -m 0755 $(@D)/android/genericLinux/lib/*.so ${1}/usr/lib
endef

define KYLIN_PLATFORM_LIB_INSTALL_ARCHIVES
  $(INSTALL) -m 0755 -d ${1}/usr/lib/realtek
  $(INSTALL) -m 0755 $(@D)/android/genericLinux/lib/*.a ${1}/usr/lib/realtek
endef

define KYLIN_PLATFORM_LIB_INSTALL_HEADERS
	$(INSTALL) -m 0755 -d ${1}/usr/include/realtek/genericLinux
	cp -arf $(@D)/android/genericLinux/include ${1}/usr/include/realtek/genericLinux
	cp -arf $(@D)/android/genericLinux/src ${1}/usr/include/realtek/genericLinux
	cp -arf $(@D)/android/bionic ${1}/usr/include/realtek/
	cp -arf $(@D)/android/device ${1}/usr/include/realtek/
	cp -arf $(@D)/android/frameworks ${1}/usr/include/realtek/
	cp -arf $(@D)/android/hardware ${1}/usr/include/realtek/
	cp -arf $(@D)/android/system ${1}/usr/include/realtek/
endef

define KYLIN_PLATFORM_LIB_INSTALL_PKGCNF
  $(INSTALL) -d -m 0755 ${1}/usr/lib/pkgconfig
  $(INSTALL) -m 0755 $(@D)/pkgconfig/* ${1}/usr/lib/pkgconfig
endef

ifeq ($(BR2_PACKAGE_KYLIN_KERNEL_4_1_17)$(BR2_PACKAGE_KYLIN_PLATFORM_BIN_KO),yy)
define KYLIN_PLATFORM_LIB_INSTALL_KERNEL_MODULES
  $(INSTALL) -d -m 0755 ${1}lib/modules/4.1.17
  cp -av $(@D)/modules/4.1.17 ${1}/lib/modules
endef
else ifeq ($(BR2_PACKAGE_KYLIN_KERNEL_4_1_35)$(BR2_PACKAGE_KYLIN_PLATFORM_BIN_KO),yy)
define KYLIN_PLATFORM_LIB_INSTALL_KERNEL_MODULES
  $(INSTALL) -d -m 0755 ${1}/lib/modules/4.1.35
  cp -av $(@D)/modules/4.1.35 ${1}/lib/modules
endef
else
  define KYLIN_PLATFORM_LIB_INSTALL_KERNEL_MODULES
  endef
endif

ifeq ($(KYLIN_PLATFORM_LIB_INSTALL_BINARIES),y)
  define KYLIN_PLATFORM_LIB_INSTALL_MISC_BINARIES
  $(INSTALL) -d -m 0755 ${1}/etc/firmware
  cp -av $(@D)/rootfs-overlay/etc/firmware ${1}/etc/firmware
  
  $(INSTALL) -m 0755 $(@D)/rootfs-overlay/etc/init.d/S30alsadaemon ${1}/etc/init.d 
  $(INSTALL) -m 0755 $(@D)/rootfs-overlay/etc/init.d/S99user-init ${1}/etc/init.d/S69user-init
  $(INSTALL) -m 0755 $(@D)/rootfs-overlay/etc/user-init.conf ${1}/etc/
    
  $(INSTALL) -d -m 0755 ${1}/sbin 
  cp -av $(@D)/rootfs-overlay/sbin ${1} 
  
  $(INSTALL) -d -m 0755 ${1}/system
  cp -av $(@D)/rootfs-overlay/system ${1} 
  
  $(INSTALL) -d -m 0755 ${1}/usr/bin
  $(INSTALL) -m 0755 $(@D)/rootfs-overlay/usr/bin/jpurun ${1}/usr/bin
  
  $(INSTALL) -d -m 0755 ${1}/usr/sbin
  $(INSTALL) -m 0755 $(@D)/rootfs-overlay/usr/sbin/ALSADaemon ${1}/usr/sbin
  $(INSTALL) -m 0755 $(@D)/rootfs-overlay/usr/sbin/se_status ${1}/usr/sbin
  endef
else
  define KYLIN_PLATFORM_LIB_INSTALL_MISC_BINARIES
  endef
endif

################################################################################

$(eval $(generic-package))

################################################################################
#
# llvm
#
################################################################################

LLVM_VERSION = 4.0.0
LLVM_SITE = http://llvm.org/releases/$(LLVM_VERSION)
LLVM_SOURCE = llvm-$(LLVM_VERSION).src.tar.xz
LLVM_LICENSE = University of Illinois/NCSA Open Source License
LLVM_LICENSE_FILES = LICENSE.TXT

HOST_LLVM_DEPENDENCIES = host-libxml2 host-zlib host-python
LLVM_DEPENDENCIES = libxml2 zlib host-python host-llvm

# Determine the name of the LLVM target to enable depending on
# the Buildroot target settings.
#
ifeq ($(BR2_i386),y)
  _LLVM_TARGET_ARCH := X86
else ifeq ($(BR2_x86_64),y)
  _LLVM_TARGET_ARCH := X86
else ifeq ($(BR2_arm),y)
  _LLVM_TARGET_ARCH := ARM
else ifeq ($(BR2_armeb),y)
  _LLVM_TARGET_ARCH := ARM
else ifeq ($(BR2_aarch64),y)
  _LLVM_TARGET_ARCH := AArch64
else ifeq ($(BR2_mips),y)
  _LLVM_TARGET_ARCH := Mips
else ifeq ($(BR2_mipsel),y)
  _LLVM_TARGET_ARCH := Mips
else ifeq ($(BR2_mips64),y)
  _LLVM_TARGET_ARCH := Mips
else ifeq ($(BR2_mips64el),y)
  _LLVM_TARGET_ARCH := Mips
else ifeq ($(BR2_powerpc),y)
  _LLVM_TARGET_ARCH := PowerPC
else ifeq ($(BR2_powerpc64),y)
  _LLVM_TARGET_ARCH := PowerPC
else ifeq ($(BR2_powerpc64le),y)
  _LLVM_TARGET_ARCH := PowerPC
else ifeq ($(BR2_sparc),y)
  _LLVM_TARGET_ARCH := Sparc
else
  $(error Target architecture not supported by LLVM)
endif


# List of build options at:
#    http://llvm.org/docs/CMake.html
#
_LLVM_COMMON_CONF_OPTS := \
  -DLLVM_DEFAULT_TARGET_TRIPLE=$(GNU_TARGET_NAME) \
  -DLLVM_TARGETS_TO_BUILD=$(_LLVM_TARGET_ARCH) \
  -DLLVM_TARGET_ARCH=$(_LLVM_TARGET_ARCH) \
  -DLLVM_ENABLE_ZLIB=YES \
  -DLLVM_INCLUDE_TOOLS=YES \
  -DLLVM_INCLUDE_EXAMPLES=NO \
  -DLLVM_INCLUDE_TESTS=NO \
  -DLLVM_BUILD_TESTS=NO \
  -DLLVM_ENABLE_PROJECTS=''

HOST_LLVM_CONF_OPTS = $(_LLVM_COMMON_CONF_OPTS)

LLVM_CONF_OPTS = $(_LLVM_COMMON_CONF_OPTS) \
  -DLLVM_TABLEGEN='$(HOST_DIR)/usr/bin/llvm-tblgen'

ifeq ($(BR2_PACKAGE_LLVM_ENABLE_FFI),y)
  LLVM_DEPENDENCIES += libffi
  LLVM_CONF_OPTS += -DLLVM_ENABLE_FFI=YES
else
  LLVM_CONF_OPTS += -DLLVM_ENABLE_FFI=NO
endif

ifeq ($(BR2_PACKAGE_LLVM_ENABLE_RTTI),y)
  LLVM_CONF_OPTS += -DLLVM_ENABLE_RTTI=YES
else
  LLVM_CONF_OPTS += -DLLVM_ENABLE_RTTI=NO
endif

ifeq ($(BR2_PACKAGE_LLVM_ENABLE_EH),y)
  LLVM_CONF_OPTS += -DLLVM_ENABLE_EH=YES
else
  LLVM_CONF_OPTS += -DLLVM_ENABLE_EH=NO
endif

# LLVM expects to always be built in a separate directory.
LLVM_SUPPORTS_IN_SOURCE_BUILD = NO

$(eval $(host-cmake-package))
$(eval $(cmake-package))

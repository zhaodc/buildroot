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
LLVM_DEPENDENCIES = libxml2 zlib host-python

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

_LLVM_COMMON_CONF_OPTS := -DLLVM_TARGETS_TO_BUILD=$(_LLVM_TARGET_ARCH) \
						  -DLLVM_ENABLE_ZLIB=YES \
						  -DLLVM_INCLUDE_TOOLS=NO \
						  -DLLVM_INCLUDE_EXAMPLES=NO \
						  -DLLVM_INCLUDE_TESTS=NO \
						  -DLLVM_BUILD_TESTS=NO \
						  -DLLVM_ENABLE_PROJECTS=''

LLVM_CONF_OPTS = $(_LLVM_COMMON_CONF_OPTS)
HOST_LLVM_CONF_OPTS = $(_LLVM_COMMON_CONF_OPTS)
LLVM_SUPPORTS_IN_SOURCE_BUILD = NO

$(eval $(host-cmake-package))
$(eval $(cmake-package))

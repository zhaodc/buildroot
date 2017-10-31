################################################################################
#
# skeleton
#
################################################################################

# The skeleton can't depend on the toolchain, since all packages depends on the
# skeleton and the toolchain is a target package, as is skeleton.
# Hence, skeleton would depends on the toolchain and the toolchain would depend
# on skeleton.
SKELETON_ADD_TOOLCHAIN_DEPENDENCY = NO
SKELETON_ADD_SKELETON_DEPENDENCY = NO

ifeq ($(BR2_TARGET_GENERIC_CABUNDLE),y)
define SYSTEM_CABUDLE
        mkdir -p $(TARGET_DIR)/etc/ssl/certs/
        $(WGET) -O $(TARGET_DIR)/etc/ssl/certs/ca-certificates.crt http://curl.haxx.se/ca/cacert.pem
endef
TARGET_FINALIZE_HOOKS += SYSTEM_CABUDLE
endif

$(eval $(virtual-package))

COBALT_VERSION = 51c5ef6805d3ede7acaa472abb7da3604a099cba
COBALT_SITE = https://cobalt.googlesource.com/cobalt
COBALT_SITE_METHOD = git


COBALT_DEPENDENCIES = host-gyp


define COBALT_CONFIGURE_CMDS
	cd $(@D)/src
	gyp --format=ninja-raspi-2 --depth=$(@D)/src --toplevel-dir=$(@D)/src -Dstarboard_path=$(@D)/src/starboard/raspi/2 -DOS=starboard  -Dcobalt_fastbuild=0 -DCC_HOST=$(TARGET_CC) -Dhost_os=linux -Dcobalt_version=90790 -Goutput_dir=out -I$(@D)/src/cobalt/build/config/base.gypi -I$(@D)/src/build/common.gypi -I$(@D)/src/starboard/raspi/2/gyp_configuration.gypi -Duse_widevine=0 -Duse_asan=0 -Dclang=0 -Dcobalt_config=debug -Duse_tsan=0 -Denable_vr=0 -Dsysroot=$(STAGING_DIR) -Dinclude_path_platform_deploy_gypi=$(@D)/src/starboard/build/deploy.gypi -Duse_openssl=1 -Dasan_symbolizer_path= -Gconfig=raspi-2_debug $(@D)/src/cobalt/build/all.gyp
endef

$(eval $(host-gyp))
$(eval $(generic-package))

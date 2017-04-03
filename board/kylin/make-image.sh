#!/bin/bash
#set -x

set -e

# these values can be overridden using exports before caling the script
if [ -z ${KERNEL_DEFCONFIG+x} ]; then KERNEL_DEFCONFIG=kylin64_kernel_defconfig;  fi
if [ -z ${KERNEL_OUTPUT_DIR+x} ]; then KERNEL_OUTPUT_DIR=output_kernel;  fi
if [ -z ${ROOTFS_DEFCONFIG+x} ]; then ROOTFS_DEFCONFIG=kylin32hf_wpe_ml_defconfig;  fi
if [ -z ${ROOTFS_OUTPUT_DIR+x} ]; then ROOTFS_OUTPUT_DIR=output_rootfs;  fi
if [ -z ${BUILDROOT_TOP_DIR+x} ]; then BUILDROOT_TOP_DIR=$PWD;  fi
if [ -z ${USB_FLASH_DIR+x} ]; then USB_FLASH_DIR=$BUILDROOT_TOP_DIR/output/usb_flash;  fi

function print_config(){
	echo "Selected kernel config: $KERNEL_DEFCONFIG"
	echo "Selected kernel output dir: $KERNEL_OUTPUT_DIR"
	echo "Selected rootfs config: $ROOTFS_DEFCONFIG"
	echo "Selected rootfs outdir dir: $ROOTFS_OUTPUT_DIR"
	echo "Selected builtroot dir: $BUILDROOT_TOP_DIR"
	echo "Selected usb flash dir: $USB_FLASH_DIR"
}

function _make(){
	make O=$1 $2
    ERR=$?
    return $ERR;
}

function make_all(){
	_make $KERNEL_OUTPUT_DIR $1
	_make $ROOTFS_OUTPUT_DIR $1
    ERR=$?
    return $ERR;
}

function config_kernel_build(){
	_make $KERNEL_OUTPUT_DIR $KERNEL_DEFCONFIG
    ERR=$?
    return $ERR;
}

function config_rootfs_build(){
	_make $ROOTFS_OUTPUT_DIR $ROOTFS_DEFCONFIG
    ERR=$?
    return $ERR;
}

function build_kernel(){
	[ -e $KERNEL_OUTPUT_DIR/.config ] || config_kernel_build
	_make $KERNEL_OUTPUT_DIR all
	ERR=$?
    return $ERR;
}

function build_rootfs(){
	[ -e $ROOTFS_OUTPUT_DIR/.config ] || config_rootfs_build
	_make $ROOTFS_OUTPUT_DIR all
	ERR=$?
    return $ERR;
}

function print_usage(){
	echo "$0 commands are:"
    echo "    clean - Clean Build"
    echo "    all - Build a USB flash drive"
    echo "    download - Prepare offline build "
    echo "    create - Create image.img"
    echo "    build  - Build kernel and rootfs"
}

function copy_ko(){
	mkdir -p $ROOTFS_OUTPUT_DIR/target
	tar -xpf $KERNEL_OUTPUT_DIR/images/kernel-modules.tar -C $ROOTFS_OUTPUT_DIR/target
    ERR=$?
    return $ERR;
}

function get_image_tools(){
	git clone git@github.com:Metrological/kylin-image.git image
    ERR=$?
    return $ERR;
}

function clean_image(){
	if [ -d image ]; then image/build_image.sh clean; fi
    ERR=$?
    return $ERR;
} 

function create_image(){
	[ -d image ] || get_image_tools
	# Satisfy Realtek image script 
	if [ -z ${KERNEL_ROOTFS+x} ]; then export KERNEL_ROOTFS=$BUILDROOT_TOP_DIR/$ROOTFS_OUTPUT_DIR/images/rootfs.ext4;  fi
	if [ -z ${KERNEL_DTB_DIR+x} ]; then export KERNEL_DTB_DIR=$BUILDROOT_TOP_DIR/$KERNEL_OUTPUT_DIR/images;  fi
	if [ -z ${KUIMAGE+x} ]; then export KUIMAGE=$BUILDROOT_TOP_DIR/$KERNEL_OUTPUT_DIR/images/Image;  fi
	
    pushd image
       ./build_image.sh clean build
       ERR=$?
    popd
    
    return $ERR;
}

function create_usb(){
	mkdir -p $USB_FLASH_DIR
	create_image 
	    
    cp -v image/image_file/install.img $USB_FLASH_DIR
    cp -v image/image_file/components/tmp/pkgfile/generic/bluecore.audio $USB_FLASH_DIR
    cp -v image/image_file/components/tmp/pkgfile/generic/rescue.root.emmc.cpio.gz_pad.img $USB_FLASH_DIR
    cp -v image/image_file/components/tmp/pkgfile/generic/rescue.emmc.dtb $USB_FLASH_DIR
    cp -v image/image_file/components/tmp/pkgfile/generic/emmc.uImage $USB_FLASH_DIR
    cp -v image/dvrboot.exe.bin $USB_FLASH_DIR
    
    ERR=$?
    return $ERR;
}

if [ "$1" = "" ]; then
    print_usage
else
    print_config
    while [ "$1" != "" ]
    do
        case "$1" in
            create)
                create_image
                ;;
            clean)
                make_all clean
                clean_image
                ;;
            download)
                config_kernel_build
                config_rootfs_build
                make_all source
                ;;
            config)
                config_kernel_build
                config_rootfs_build
                ;;                   
            build)
                build_kernel
                copy_ko
                build_rootfs
                ;;                    
            all)
                build_kernel
                copy_ko
                build_rootfs
                create_usb
                ;;
            *)
                echo -e "$0 \033[47;31mUnknown CMD: $1\033[0m"
                print_usage
                exit 1
                ;;
        esac
        shift 1
    done
fi

exit $ERR

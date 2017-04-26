#!/bin/sh
set -x
set -e

BOARD_DIR="$(dirname $0)"

[ -d ${HOST_DIR}/arris-packaging-tool ] ||  git clone git@github.com:Metrological/arris-packaging-tool.git ${HOST_DIR}/arris-packaging-tool
[ -f ${HOST_DIR}/arris-packaging-tool/arris_package_br.sh ] && ${HOST_DIR}/arris-packaging-tool/arris_package_br.sh  ${BINARIES_DIR} rootfs.cpio.xz

#!/bin/sh
BOARD_DIR="$(dirname $0)"
ROOTFS_DIR="${BINARIES_DIR}/../rootfs"
ROOTFS_FILES="${BINARIES_DIR}/rootfs.files"

echo "Binaries: ${BINARIES_DIR}"
echo "Target: ${TARGET_DIR}"

# Temp rootfs dir
mkdir -p "${ROOTFS_DIR}"

echo "/lib/modules" >> "${ROOTFS_FILES}"

rsync -ar --files-from="${ROOTFS_FILES}" "${TARGET_DIR}" "${ROOTFS_DIR}"

# Create tar
tar -cf "${BINARIES_DIR}/kernel-modules.tar" -C "${ROOTFS_DIR}" .

# Cleaning up
rm -rf "${ROOTFS_FILES}"
rm -rf "${ROOTFS_DIR}"

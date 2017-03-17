#!/bin/sh
BOARD_DIR="$(dirname $0)"
ROOTFS_DIR="${BINARIES_DIR}/../rootfs"
ROOTFS_FILES="${BINARIES_DIR}/rootfs.files"
STAR="*"

echo "Binaries: ${BINARIES_DIR}"
echo "Target: ${TARGET_DIR}"

# Clean up target
rm -rf "${TARGET_DIR}/usr/lib/gstreamer-1.0/include"
rm -rf "${TARGET_DIR}/usr/lib/libstdc++.so.6.0.20-gdb.py"
rm -rf "${TARGET_DIR}/etc/ssl/man"

# Temp rootfs dir
mkdir -p "${ROOTFS_DIR}"

# Create files list for rsync
rm -rf "${ROOTFS_FILES}"
while read line
do
	if find "${TARGET_DIR}" -name "$line" -print -quit | grep -q "${TARGET_DIR}" 
	then
		find "${TARGET_DIR}" -name "$line" -printf "%P\n" >> "${ROOTFS_FILES}"
	else 
		echo "Missing $line"
  		exit 1
	fi
done < "${BOARD_DIR}/realtek.txt"

# Append missing folders
echo "usr/lib/gstreamer-1.0" >> "${ROOTFS_FILES}"
echo "usr/lib/gio" >> "${ROOTFS_FILES}"
echo "usr/share/X11" >> "${ROOTFS_FILES}"
echo "usr/share/mime" >> "${ROOTFS_FILES}"
echo "etc/playready" >> "${ROOTFS_FILES}"
echo "etc/ssl" >> "${ROOTFS_FILES}"
echo "etc/fonts" >> "${ROOTFS_FILES}"

rsync -ar --files-from="${ROOTFS_FILES}" "${TARGET_DIR}" "${ROOTFS_DIR}"

# Default font
mkdir -p "${ROOTFS_DIR}/usr/share/fonts/ttf-bitstream-vera"
cp -f "${TARGET_DIR}/usr/share/fonts/ttf-bitstream-vera/Vera.ttf" "${ROOTFS_DIR}/usr/share/fonts/ttf-bitstream-vera/"

# WebServer path
mkdir -p "${ROOTFS_DIR}/www"

# Create tar
tar -cvf "${BINARIES_DIR}/realtek.tar" -C "${ROOTFS_DIR}" .

# Cleaning up
rm -rf "${ROOTFS_FILES}"
rm -rf "${ROOTFS_DIR}"

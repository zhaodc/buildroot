#!/bin/sh
BOARD_DIR="$(dirname $0)"

mkdir -p $TARGET_DIR/etc/ap_wlan0

cp -v $BOARD_DIR/config/wpa_ap.conf $TARGET_DIR/etc/ap_wlan0
cp -v $BOARD_DIR/config/wlan_dhcp_ap.conf $TARGET_DIR/etc/ap_wlan0
cp -v $BOARD_DIR/config/interfaces $TARGET_DIR/etc/network
cp -v $BOARD_DIR/config/S41startAP $TARGET_DIR/etc/init.d

# Copy index.html page for WPE Framework
if [ -f "${BOARD_DIR}/index.html" ]; then
	mkdir -p "${TARGET_DIR}/www/"
	cp -pvf "${BOARD_DIR}/index.html" "${TARGET_DIR}/www/"
fi

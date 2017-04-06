#!/bin/sh
BOARD_DIR="$(dirname $0)"

mkdir -p $TARGET_DIR/etc/ap_wlan0

cp -v $BOARD_DIR/config/wpa_ap.conf $TARGET_DIR/etc/ap_wlan0
cp -v $BOARD_DIR/config/wlan_dhcp_ap.conf $TARGET_DIR/etc/ap_wlan0
cp -v $BOARD_DIR/config/interfaces $TARGET_DIR/etc/network
cp -v $BOARD_DIR/config/S41startAP $TARGET_DIR/etc/init.d

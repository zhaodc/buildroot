start() {
        echo -n "Starting access point on wlan0: "
        /sbin/ifup wlan0
        start-stop-daemon -S -q -b -m -p /var/run/wlan0_udhcpd.pid --exec /usr/sbin/udhcpd -- /etc/ap_wlan0/wlan_dhcp_ap.conf </dev/null >/dev/null 2>&1
        start-stop-daemon -S -q -b -m -p /var/run/wlan0_ap_wpa_supplicant.pid --exec /usr/sbin/wpa_supplicant -- -B -i wlan0 -c /etc/ap_wlan0/wpa_ap.conf </dev/null >/dev/null 2>&1
        [ $? == 0 ] && echo "OK" || echo "FAIL"
}

stop() {
        echo -n "Stopping access point on wlan0: "
        start-stop-daemon -K -q -p /var/run/wlan0_ap_wpa_supplicant.pid
        start-stop-daemon -K -q -p /var/run/wlan0_udhcpd.pid
        /sbin/ifdown wlan0
        [ $? == 0 ] && echo "OK" || echo "FAIL"

        rm -rf /var/run/ifdown wlan0.pid
        rm -rf /var/run/wlan0_udhcpd.pid
}
restart() {
        stop
        sleep 1
        start
}

case "$1" in
        start)
                start
                ;;
        stop)
                stop
                ;;
        restart|reload)
                restart
                ;;
        *)
                echo "Usage: $0 {start|stop|restart}"
                exit 1
esac

exit $?

#!/bin/sh
# Installs the Quad9 DNS dispatcher script to /etc/NetworkManager/dispatcher.d/
# and enables the NetworkManager dispatcher service

DISPATCHER_DST="/etc/NetworkManager/dispatcher.d/10-dns-quad9"

# Enable and unmask the dispatcher service
systemctl unmask NetworkManager-dispatcher.service 2>/dev/null || true
systemctl enable NetworkManager-dispatcher.service 2>/dev/null || true

# Check if file exists and prompt before overwriting
if [ -f "$DISPATCHER_DST" ]; then
    gum confirm "File $DISPATCHER_DST already exists. Overwrite?" || {
        echo "Skipping — existing file left unchanged."
        exit 0
    }
fi

# Write the dispatcher script (requires sudo)
sudo tee "$DISPATCHER_DST" << 'DISPATCHER_EOF'
#!/bin/sh
# Set Quad9 (9.9.9.9) as default DNS on every interface up
# Waits for NM to finish pushing DHCP DNS (v4+v6) before overriding
# Revert to DHCP DNS for captive portals by running: dns-dhcp
# Switch back to Quad9 after portal auth by running: dns-quad

[ "$2" = "up" ] || exit 0

# Skip loopback and common virtual interfaces
case "$1" in
    lo|docker*|veth*|br-*|virbr*) exit 0 ;;
esac

# If sentinel file exists, skip override (user manually switched to DHCP DNS)
[ -f /tmp/dns-skip-quad9 ] && exit 0

# Background: wait for NM's DNS pushes to stabilize, then override
(
    prev=""
    stable=0
    for i in $(seq 1 30); do
        sleep 1
        curr=$(resolvectl status "$1" 2>/dev/null | grep "DNS Servers:" | head -1)
        if [ "$curr" = "$prev" ] && [ -n "$curr" ]; then
            stable=$((stable + 1))
            [ $stable -ge 2 ] && break
        else
            stable=0
        fi
        prev="$curr"
    done
    # Save DHCP DNS for later restoration by dns-dhcp
    echo "$curr" | sed 's/.*DNS Servers: //' > /tmp/dns-dhcp-saved
    resolvectl dns "$1" 9.9.9.9 149.112.112.112 2620:fe::fe 2620:fe::9
) &
DISPATCHER_EOF

sudo chmod 755 "$DISPATCHER_DST"
sudo chown root:root "$DISPATCHER_DST"

echo "Quad9 DNS dispatcher installed to $DISPATCHER_DST"

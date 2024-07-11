#!/bin/bash

# Check if the VPN interface is up (replace tun0 with your VPN interface)
if ip link show proton0 2>/dev/null | grep -q "UNKNOWN"; then
    echo "VPN: Connected"
else
    echo "VPN: Disconnected"
fi

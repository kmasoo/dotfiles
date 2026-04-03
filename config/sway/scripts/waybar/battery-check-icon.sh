#!/bin/bash
# Check for battery presence

if ls /sys/class/power_supply/BAT* >/dev/null 2>&1; then
    echo ""
else
    echo ""
fi

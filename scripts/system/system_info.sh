#!/bin/bash

# System Information Script
# This script displays system information including CPU usage, memory usage, disk usage, and network status.

function cpu_usage {
    echo "CPU Usage:"
    mpstat | grep -A 5 "%idle" | tail -n 1 | awk '{print "CPU Load: " 100 - $ 12"%"}'
}

function memory_usage {
    echo -e "\nMemory Usage:"
    free -h | awk '/^Mem:/ {print "Total: "$2"\nUsed: "$3"\nFree: "$4}'
}

function disk_usage {
    echo -e "\nDisk Usage:"
    df -h | awk '$NF=="/"{printf "Disk Usage: %s/%s (%s)\n", $3,$2,$5}'
}

function network_status {
    echo -e "\nNetwork Status:"
    ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1 | awk '{print "IP Address: "$1}'
    ss -tuln | grep LISTEN
}

function main {
    echo "System Information"
    echo "==================="
    cpu_usage
    memory_usage
    disk_usage
    network_status
}

main

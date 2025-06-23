#!/bin/bash

lsblk

read -rp "Enter disk device (e.g., /dev/sda): " DISK
if [ ! -b "$DISK" ]; then
    echo "❌ Error: $DISK is not a valid block device."
    exit 1
fi

# Get total disk size in bytes
DISK_SIZE_BYTES=$(blockdev --getsize64 "$DISK")
DISK_SIZE_GB=$((DISK_SIZE_BYTES / 1024 / 1024 / 1024))

echo "Disk size: ${DISK_SIZE_GB}G"

# Prompt for EFI size
read -rp "Enter EFI partition size (e.g., 1G): " EFI_PART_SIZE
EFI_PART_SIZE=${EFI_PART_SIZE:-1G}

# Prompt for LVM size with % support
read -rp "Enter LVM partition size (e.g., 150G or 60%): " LVM_PART_INPUT

if [[ "$LVM_PART_INPUT" =~ ^([0-9]{1,3})%$ ]]; then
    # Extract percentage and compute size
    PERCENT=${BASH_REMATCH[1]}
    LVM_PART_SIZE_GB=$(echo "($DISK_SIZE_GB * $PERCENT + 99) / 100")
    LVM_PART_SIZE="${LVM_PART_SIZE_GB}"
else
    LVM_PART_SIZE="$LVM_PART_INPUT"
fi

echo "Final values:"
echo "DISK = $DISK"
echo "EFI_PART_SIZE = $EFI_PART_SIZE"
echo "LVM_PART_SIZE = $LVM_PART_SIZE"

 if [ -f "$(dirname "$0")/config/paths/src" ]; then
    source "$(dirname "$0")/config/paths/src"
  else
    echo "Exiting CodexBox..."
    sleep 10
    exit 1
  fi


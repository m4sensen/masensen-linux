#!/bin/bash

# --- Configuration ---
# Set these variables before running the script
# Example: DISK="/dev/sda"
# Example: LVM_PART_SIZE=50 # in GB
# Example: EFI_PART_SIZE=1 # in GB

: "${DISK:?Error: DISK variable not set. Please set it (e.g., /dev/sda)}"
: "${LVM_PART_SIZE:?Error: LVM_PART_SIZE not set (in GB)}"
: "${EFI_PART_SIZE:=1}"  # default to 1GB if not set

# Convert to MiB
EFI_PART_SIZE_MIB=$((EFI_PART_SIZE * 1024))
LVM_PART_SIZE_MIB=$((LVM_PART_SIZE * 1024))

echo "*****************************************************"
echo "WARNING: This will ERASE all data on $DISK!"
echo "Press Ctrl+C to cancel. Waiting 10 seconds..."
echo "*****************************************************"
sleep 10

# Check if disk exists
if [ ! -b "$DISK" ]; then
    echo "Error: Disk $DISK not found!"
    exit 1
fi

echo "Unmounting any mounted partitions on $DISK..."
for mp in $(lsblk -ln "$DISK" | awk '{print $1}' | grep -E "^$(basename $DISK)[0-9]+" | sed "s|^|/dev/|" | tac); do
    mountpoint=$(findmnt -nr -o TARGET "$mp")
    if [ -n "$mountpoint" ]; then
        echo "Unmounting $mountpoint..."
        sudo umount "$mp" || echo "Warning: Could not unmount $mp"
    fi
done

# Create GPT partition table
echo "Creating GPT partition table..."
sudo parted -s "$DISK" mklabel gpt || { echo "Failed to create GPT label."; exit 1; }

# Create EFI partition
echo "Creating EFI partition..."
sudo parted -s "$DISK" mkpart ESP fat32 1MiB "${EFI_PART_SIZE_MIB}MiB" || exit 1
sudo parted -s "$DISK" set 1 esp on || exit 1

# Create LVM partition
LVM_START_MIB=$((EFI_PART_SIZE_MIB + 1))
LVM_END_MIB=$((LVM_START_MIB + LVM_PART_SIZE_MIB))
echo "Creating LVM partition..."
sudo parted -s "$DISK" mkpart primary ext4 "${LVM_START_MIB}MiB" "${LVM_END_MIB}MiB" || exit 1
sudo parted -s "$DISK" set 2 lvm on || exit 1

# Create EXT4 partition in remaining space
PART3_START_MIB=$((LVM_END_MIB + 1))
echo "Creating EXT4 partition..."
sudo parted -s "$DISK" mkpart primary ext4 "${PART3_START_MIB}MiB" 100% || exit 1

# Show partition table
echo "Partitioning complete:"
sudo parted "$DISK" print
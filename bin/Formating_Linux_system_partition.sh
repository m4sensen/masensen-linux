cryptsetup luksFormat ${DISK}2

cryptsetup open ${DISK}2 cryptroot

pvcreate /dev/mapper/cryptroot
vgcreate vg0 /dev/mapper/cryptroot

lvcreate -L 20G vg0 -n swap

lvcreate -l 100%FREE vg0 -n root

lsblk
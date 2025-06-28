mkswap /dev/mapper/vg0-swap  # sudo mkswap /dev/mapper/vg0-lv--swap
swapon /dev/mapper/vg0-swap

lsblk -f
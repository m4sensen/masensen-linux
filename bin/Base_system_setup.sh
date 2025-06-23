pacstrap /mnt base base-devel linux linux-firmware btrfs-progs nano

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
pacman -Syy lvm2
nano /etc/mkinitcpio.conf

mkinitcpio -P
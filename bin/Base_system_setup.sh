echo "add this to [options]
RetryDelay = 5
ParallelDownloads = 5
"

nano "/etc/pacman.conf"

pacstrap /mnt base
pacstrap /mnt base-devel
pacstrap /mnt linux 
pacstrap /mnt linux-firmware 
pacstrap /mnt btrfs-progs 
pacstrap /mnt nano

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
pacman -Syy lvm2

echo "add btrfs lvm2 resume"
sleep 10

nano /etc/mkinitcpio.conf

mkinitcpio -P
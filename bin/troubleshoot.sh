cryptsetup open ${DISK}2 cryptroot

vgchange -ay

mkdir -p /mnt/{home,.snapshots,vms,var,tmp,boot}
mkdir -p /mnt/var/{log,cache,lib/pacman}

mount -o subvol=@,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt

mkdir -p /mnt/{home,.snapshots,vms,var,tmp,boot}

mount -o subvol=@home,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/home
mount -o subvol=@snapshots,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/.snapshots
mount -o subvol=@tmp,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/tmp
mount -o subvol=@vms,noatime,nodatacow,ssd /dev/mapper/vg0-root /mnt/vms

mount -o subvol=@var,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/var

mkdir -p /mnt/var/{log,cache,lib/pacman}

mount -o subvol=@log,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/var/log
mount -o subvol=@cache,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/var/cache
mount -o subvol=@pkg,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt/var/lib/pacman

mount ${DISK}1 /mnt/boot

swapon /dev/mapper/vg0-swap

mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /run /mnt/run

mount --bind /sys/firmware/efi/efivars /mnt/sys/firmware/efi/efivars #on efi

arch-chroot /mnt
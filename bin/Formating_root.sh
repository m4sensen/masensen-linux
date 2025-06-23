#
mkfs.btrfs /dev/mapper/vg0-root
#
mount /dev/mapper/vg0-root /mnt
#
btrfs subvolume create /mnt/@             # Root filesystem
btrfs subvolume create /mnt/@home         # User home directory
btrfs subvolume create /mnt/@snapshots    # Snapshots (for Snapper/Timeshift)
btrfs subvolume create /mnt/@vms          # VM disk images
btrfs subvolume create /mnt/@var          # General /var
btrfs subvolume create /mnt/@log          # /var/log - logs
btrfs subvolume create /mnt/@cache        # /var/cache - caches
btrfs subvolume create /mnt/@pkg          # /var/lib/pacman - package DB & cache
btrfs subvolume create /mnt/@tmp          # /var/tmp - temp files
#
umount /mnt
#
mount -o subvol=@,rw,noatime,autodefrag,ssd,comporess=zstd /dev/mapper/vg0-root /mnt
#
mkdir /mnt/home
mkdir /mnt/.snapshots
mkdir /mnt/vms
mkdir /mnt/var
mkdir /mnt/var/log
mkdir /mnt/var/cache
mkdir /mnt/var/lib/pacman
mkdir /mnt/tmp
#
mount -o subvol=@home,rw,noatime,autodefrag,ssd,comporess=zstd /dev/mapper/vg0-root /mnt/home

mount -o subvol=@snapshots,rw,noatime,autodefrag,ssd,comporess=zstd /dev/mapper/vg0-root /mnt/.snapshots

mount -o subvol=@vms,noatime, nodatacow,ssd /dev/mapper/vg0-root /mnt/vms

mount -o subvol=@var,rw,noatime,autodefrag,ssd,comporess=zstd /dev/mapper/vg0-root /mnt/var

mount -o subvol=@log,rw,noatime,autodefrag,ssd,comporess=zstd /dev/mapper/vg0-root /mnt/var/log

mount -o subvol=@cache,rw,noatime,autodefrag,ssd,comporess=zstd /dev/mapper/vg0-root /mnt/var/cache

mount -o subvol=@pkg,rw,noatime,autodefrag,ssd,comporess=zstd /dev/mapper/vg0-root /mnt/var/lib/pacman

mount -o subvol=@tmp,rw,noatime,autodefrag,ssd,comporess=zstd /dev/mapper/vg0-root /mnt/tmp
#
mkdir -p mnt/boot
mount /dev/sda1 mnt/boot
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

btrfs subvolume list /mnt

sleep 10

#
umount /mnt
#
mount -o subvol=@,rw,noatime,autodefrag,ssd,compress=zstd /dev/mapper/vg0-root /mnt
#

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

#
mount ${DISK}1 /mnt/boot

sleep 10
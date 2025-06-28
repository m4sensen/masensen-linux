Here's a complete and clean `README.md` file tailored for your custom **Arch Linux installer** setup, including:

* UEFI with GRUB
* LUKS encryption with LVM
* Btrfs with subvolumes
* Separate EXT4 partition for personal files (`/secure`)
* AppArmor folder protection

---

````markdown
# Arch Linux Custom Installer

This project provides a **custom Arch Linux installation** setup using:

- UEFI + GRUB bootloader  
- Full disk encryption with **LUKS on LVM**  
- **Btrfs** root filesystem with subvolumes  
- Separate **/secure** EXT4 partition for personal data  
- **AppArmor** folder protection for enhanced security

---

## System Layout

### Disk Partitioning (`/dev/sda`):

| Partition | Filesystem | Mount Point | Purpose |
|----------|------------|-------------|---------|
| `/dev/sda1` | FAT32 (ESP) | `/boot` (mounted with `boot/efi`) | EFI system partition |
| `/dev/sda2` | LUKS → LVM → Btrfs | `/` | Encrypted root with LVM and Btrfs subvolumes |
| `/dev/sda3` | EXT4 | `/secure` | Separate unencrypted (or encrypted at rest) partition for personal files |

### LVM Logical Volumes:

- `lv-root` → Btrfs subvolumes:
  - `@` → `/` (root)
  - `@home` → `/home`
  - `@snapshots` → `/.snapshots`
  - `@log` → `/var/log`
  - `@cache` → `/var/cache`
  - `@pkg` → `/var/cache/pacman/pkg`
- `lv-swap` → Swap (20 GB, hibernation enabled)

---

## Boot Parameters

GRUB config (`/etc/default/grub`):

```bash
GRUB_CMDLINE_LINUX="cryptdevice=UUID=<UUID-of-sda2>:cryptroot:allow-discards root=/dev/mapper/vg0-lv-root rootfstype=btrfs rootflags=subvol=@ resume=/dev/vg0/lv-swap"
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=3"
````

---

## Filesystem Features

* **Btrfs Options**:

  * Compression: `zstd`
  * Mount flags: `noatime,compress=zstd,ssd,space_cache=v2,autodefrag`
  * Snapshots supported via Snapper or Btrbk

* **/secure** EXT4:

  * Mounted at boot
  * Ownership: user `codex`
  * Used for sensitive, personal data
  * Optionally encrypted separately (e.g., via `fscrypt`)

---

## Security Enhancements

* **LUKS2 Encryption**:

  * Full disk encryption except for `/boot`
  * Allows discard/TRIM

* **AppArmor**:

  * Enabled and enforced
  * Profiles configured for sensitive directories
  * Folder-level protection (deny-all + allowlists)

---

## Services Enabled

* `gdm` – GNOME Display Manager
* `NetworkManager` – Internet connection
* `apparmor` – Mandatory access control
* `snapper` or `btrbk` (optional) – Snapshots

---

## Installation Script Features

* Interactive or preset-based setup
* Generates `/etc/fstab` with UUIDs
* Initializes LUKS, LVM, Btrfs, EXT4
* Installs GRUB to EFI system
* Configures mkinitcpio hooks:

  ```
  HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block encrypt lvm2 resume filesystems fsck)
  ```

---

## Post-Install Checklist

* [ ] Set user password: `passwd`
* [ ] Configure locale, time, hostname
* [ ] Review AppArmor profiles
* [ ] Install preferred desktop environment (GNOME and/or Sway)
* [ ] Enable auto-mount of `/secure` (via `/etc/fstab`)
* [ ] Configure `snapper` or `btrbk` for backups

---

## Example Mount Commands (During Install)

```bash
mount -o noatime,compress=zstd,ssd,space_cache=v2,subvol=@ /dev/mapper/vg0-lv-root /mnt
mkdir -p /mnt/{boot/efi,home,.snapshots,var/log,var/cache,var/cache/pacman/pkg}
mount -o subvol=@home     /dev/mapper/vg0-lv-root /mnt/home
mount -o subvol=@snapshots /dev/mapper/vg0-lv-root /mnt/.snapshots
mount -o subvol=@log      /dev/mapper/vg0-lv-root /mnt/var/log
mount -o subvol=@cache    /dev/mapper/vg0-lv-root /mnt/var/cache
mount -o subvol=@pkg      /dev/mapper/vg0-lv-root /mnt/var/cache/pacman/pkg
mount /dev/sda1 /mnt/boot/efi
mount /dev/sda3 /mnt/secure
```

---

## License

MIT License – Feel free to adapt and share this installer.

---

## Author

Custom setup maintained by `codex`
System hostname: `codexHost`

```

---

Let me know if you want to split this into smaller files, auto-generate from a script, or turn it into a website/wiki format.
```

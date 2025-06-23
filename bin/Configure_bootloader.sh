pacman -S grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

blkid -s UUID -o value /dev/sda2 >> /etc/default/grub

echo "Uncomment : GRUB_ENABLE_CRYPTODISK=y"

echo "
At the bottom of the file cut the last line

In nano : 
CTRL + K => cut
CTRL + U => paste
"

sleep 10

echo 'GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"' >> /etc/default/grub
echo 'GRUB_CMDLINE_LINUX="cryptdevice=UUID=[YOUR_SDA2_UUID]:cryptroot:allow-discards root=/dev/mapper/vg0-lv--root rootfstype=btrfs rootflags=subvol=@ resume=/dev/vg0/lv-swap"' >> /etc/default/grub

nano /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg
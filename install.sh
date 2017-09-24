# arch linux install steps and notes

mkfs.ext4 -L "Arch Linux" /dev/sda6
mount /dev/sda6 /mnt 
#connect to internet
pacstrap /mnt base
mkdir -p /mnt/boot/efi 
#mount efi partition on boot 
mount /dev/sda1 /mnt/boot/efi 
genfstab -p /mnt | tee /mnt/etc/fstab
arch-chroot /mnt 
#set root password
passwd 

#install bootloader
pacman -Syu grub efibootmgr
grub-mkconfig -o /boot/grub/grub.cfg
grub-install /dev/sda

pacman -Syu gnome-desktop xterm vim gdm sudo 
pacman -Syu wpa_supplicant wireless_tools networkmanager network-manager-applet gnome-keyring
systemctl enable NetworkManager.service
systemctl enable wpa_supplicant.service
systemctl enabl gdm 
useradd -G wheel -s /bin/bash -m -c "Ilya" ilya 
passwd ilya

#Add yourself to sudoers
vim /etc/sudoers
#then uncomment line: %wheel ALL=(ALL) ALL

reboot
pacman -Syu os-prober
grub-mkconfig -o /boot/grub/grub.cfg

#Connecting to wifi
wpa_supplicant -B -i wlp1s0 -c <(wpa_passphrase "PLUSNET-9NTC" "!PasswordHere!")
dhcpcd wlp1s0 


#INSTALLED
pacman -Syu gnome-desktop vim gdm sudo gnome-terminal
pacman -Syu xterm wpa_supplicant wireless_tools networkmanager
pacman -Syu wpa_supplicant wireless_tools networkmanager network-manager-applet gnome-keyring


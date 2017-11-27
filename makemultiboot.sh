#!/bin/bash


script=$(readlink -f "$0")
scriptpath=$(dirname "$script")

# U basic files path
basicpath="$scriptpath/ubasic"
# target u disk
targetdev="$1"

function asktocontinue () {
  echo -n "Want to continue?(y/n)"
  answer=""
  read  answer
  #echo  $answer
  if [ ! $answer = 'y' ] && [ ! $answer = 'Y' ] || [ ! $answer ]; then
	echo "Abort."
	exit 
  fi
  
  echo "Continue."
  
  
}

echo "U disk basic file are in" "$1"
echo ""
echo "Target device is" "$2"
echo ""
asktocontinue


#==============================================
echo ""
echo "Begin to erase device head sectors data"
echo ""

dd if=/dev/zero of="$targetdev" bs=10M count=1
echo ""

echo "Erase finished."
asktocontinue

#========================================

echo ""
echo "Begin to part disk"
echo ""
fdisk "$targetdev" << EOF
o
n






a
t
b
p
w
EOF

echo ""
echo "Parting disk finished."
asktocontinue

#======================================
echo ""
echo "Begin to format as FAT32"
echo ""

mkfs.vfat "$targetdev"1

echo ""
echo "Formatting finished."
asktocontinue

#======================================
echo ""
echo "Begin to write syslinux MBR to target device"
echo ""

dd if="$basicpath"/syslinux/mbr.bin of="$targetdev"

echo ""
echo "Writing MBR finished."
asktocontinue
#========================================
echo ""
echo "Begin to install syslinux to target device partition"
echo ""

mountdir="/tmp/tmp-mkbootu"
mkdir "$mountdir"
mount "$targetdev"1 "$mountdir"
mkdir "$mountdir"/syslinux
umount "$mountdir"

echo ""
echo "Installing syslinux finished."
asktocontinue

#=============================
echo ""
echo "Begin to copy other needed files to target device partition"
echo ""
syslinux -d syslinux -f -i "$targetdev"1

mount "$targetdev"1 "$mountdir"
cp -r "$basicpath"/* "$mountdir"
umount "$mountdir"

echo ""
echo "Copying finished."
#=======
echo ""
echo "All finished."
echo "Modify grub4dos/menu.lst according to your need"
echo ""


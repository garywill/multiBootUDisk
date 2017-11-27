# Multi boot Udisk

Make a multi boot udisk on Linux. 

Can boot windows/linux. 

Can boot from a .iso file, in this case no need extracting to udisk. 

Still able to use this udisk space as general storage.

## How it work
`syslinux` as udisk's legacy bios boot.

`syslinux` menu has an option to boot into `grub4dos`

`grub4dos` menu has many options to various maintain/tool/system/installation

### Why this way?
`syslinux` is a legacy bootloader which is competitable for many machines.

`grub4dos`supports iso file boot. 

## What it can boot

I have successfully done these now:
1. Clonezilla , a linux cloning tool
2. Windows PE (support iso boot)
3. puppy linux
4. Windows 7/8 and it's Installation
5. Windows XP and it's Installation (support iso boot) (workaround. some machines fail)
6. Ubuntu (support iso boot)

## Usage

Procedure: (Following can be done by the shell script.)
1. Make msdos partition table on udisk
2. Make a partition on udisk, like `/dev/sdb1`
3. Set `/dev/sdb1` boot flag
4. Format `/dev/sdb1` as FAT32
5. Write `syslinux` MBR to target `/dev/sdb`
6. Copy `syslinux` files, `grub4dos` files and others to `/dev/sdb1`

Manually put .iso files (you prepare it) to udisk. 

Not everything support booting from iso file. For some isos you need to extract them and put files into udisk (I have no idea which, try it yourself or google "grub4dos boot iso [your boot iso]" )

Above should be done before you put other unrelated files (your photo, music etc. for general storage) into udisk, to make sure the files is physically continous and not far away from MBR.

`grub4dos/menu.lst` is the key to success. It tells you where to put your files. Read it and modify it according to your need.


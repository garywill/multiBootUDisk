# Multi boot Udisk

Make a multi-boot udisk (usb flash disk) on Linux. 

Can boot Windows/Linux. 

Can boot from a `.iso` file, in this case no need extracting to udisk. 

Still able to use this udisk space as general storage. (All files are on an FAT32 partition)

## How it work
Uses [syslinux](http://www.syslinux.org) as udisk's legacy BIOS bootloader.

On syslinux menu, an entry to boot [grub4dos](http://grub4dos.sourceforge.net/) (a fork of grub) ([Github page](https://github.com/chenall/grub4dos)).

On grub4dos menu there are many entries to boot various maintain tools, systems, system installations. (You can customize your entries)

### Why this way?
`syslinux` is a legacy bootloader which is competitable for many machines.

`grub4dos` supports `.iso` file boot. 

## What it can boot

For now I successfully boot:
1. Clonezilla , a linux cloning tool
2. Windows PE (support iso boot)
3. puppy linux
4. Windows 7/8 and it's Installation
5. Windows XP and it's Installation (support iso boot) (workaround. some machines fail)
6. Ubuntu (support iso boot)

## Usage

Procedure: (Following can be done by the shell script `makemultiboor.sh`.)
1. Make an msdos partition table on udisk
2. Make a partition on udisk, for example `/dev/sdb1`
3. Set `/dev/sdb1` boot flag
4. Format `/dev/sdb1` as FAT32
5. Write `syslinux` MBR to target `/dev/sdb`
6. Copy `syslinux` files, `grub4dos` files and others to `/dev/sdb1` (copy all files in `ubasic` folder to udisk)

Manually put your `.iso` files to udisk. 

Some support booting from `.iso` file, some doesn't. For those that doesn't support, you need to extract them and put files into udisk. 
To find out which support and which doesn't, try it yourself or google "grub4dos boot iso <what you want to boot from .iso>".

Above should be done before you put other files (photo, music etc. for general storage) into udisk, to make sure the system or `.iso` files is physically continous and not far away from MBR.

**`grub4dos/menu.lst` is the key to success. Read it and modify it according to your need.**

> In this repo `syslinux` and `grub4dos` binaries are not latest.

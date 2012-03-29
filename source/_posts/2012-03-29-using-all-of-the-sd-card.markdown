---
layout: post
title: "Using All of the SD Card"
date: 2012-03-29 11:58
comments: true
categories: 
---

Option 1: Set IMAGE_ROOTFS_SIZE Before You Build
------------------------------------------------

The SD card images created by chumby-oe are designed to fit on a 512Mb SD card.
The image size is set in `chumby-oe/meta-chumby/conf/machine/chumby-falconwing.conf`
with this line:
```
IMAGE_ROOTFS_SIZE = "450000"
```
The size is in Kbytes and is set a little smaller than the final card size to allow for
overheads like the boot loader.


Option 2: Add a New Partition
-----------------------------

You can add a new partition to fill any unused space on your SD card.
The default 512Mb disk image contains two partitions:

```
root@chumby-falconwing:/media/card# fdisk -l /dev/mmcblk0

Disk /dev/mmcblk0: 1018 MB, 1018691584 bytes
1 heads, 16 sectors/track, 124352 cylinders, total 1989632 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

        Device Boot      Start         End      Blocks   Id  System
/dev/mmcblk0p1   *           4       32771       16384   53  OnTrack DM6 Aux3
/dev/mmcblk0p2           32772      932771      450000   83  Linux
```

Using the chumby itself you can add a new partition in the unused space,
format it, and mount it.  The steps are as follows:

###Step 1. Edit the Partition Table

cfdisk is available on the default chumby-oe image, and provides a reasonably
friendly interface for adding a partition.

```
cfdisk /dev/mmcblk0
```

```
                          cfdisk (util-linux-ng 2.18)

                            Disk Drive: /dev/mmcblk0
                        Size: 1018691584 bytes, 1018 MB
              Heads: 1   Sectors per Track: 16   Cylinders: 124352

    Name        Flags      Part Type  FS Type          [Label]        Size (MB)
 ------------------------------------------------------------------------------
    mmcblk0p1   Boot, NC    Primary   OnTrack DM6 Aux3                    16.78*
    mmcblk0p2               Primary   ext3                               460.80*
                            Pri/Log   Free Space                         541.12*



     [   Help   ]  [   New    ]  [  Print   ]  [   Quit   ]  [  Units   ]
     [  Write   ]

```
 - Move the cursor to the free space
 - Select `New`
 - Select `Primary`
 - Accept the default size (541.11MB for my 1Gb SD card)
 - Select `Write`
 - Type `yes` in response to `Warning!!  This may destroy data on your disk!`
 - Select `Quit`

###Step 2. Format the Partition

```
root@chumby-falconwing:~# mkfs.ext3 -b 4096 /dev/mmcblk0p3 
mke2fs 1.41.14 (22-Dec-2010)
warning: Unable to get device geometry for /dev/mmcblk0p3
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
33040 inodes, 132107 blocks
6605 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=138412032
5 block groups
32768 blocks per group, 32768 fragments per group
6608 inodes per group
Superblock backups stored on blocks: 
        32768, 98304

Writing inode tables: done                            
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 22 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
```

###Step 3. Add the Parition to /etc/fstab

Edit fstab.  The example below will mount the new partition
as `/media/card`.

```
root@chumby-falconwing:~# vi /etc/fstab 

# stock fstab - you probably want to override this with a machine specific one

rootfs               /                    auto       defaults              1  1
proc                 /proc                proc       defaults              0  0
devpts               /dev/pts             devpts     mode=0620,gid=5       0  0
usbfs                /proc/bus/usb        usbfs      defaults              0  0
tmpfs                /var/volatile        tmpfs      defaults              0  0
tmpfs                /dev/shm             tmpfs      mode=0777             0  0
tmpfs                /media/ram           tmpfs      defaults              0  0

# add this line to mount the new partition at /media/card
/dev/mmcblk0p3       /media/card          auto       defaults,sync         0  2
```

###Step 4. Mount the Partition

```
root@chumby-falconwing:/media/card# mount -a
```

Option 3: Expand the Partition to Fill the Disk
-----------------------------------------------

This is possible by 
 - use cfdisk resize partition 2 to fill the disk
 - use resize2fs to expand the ext3 partition to fill the partition

You cannot run this procedure while the device is mounted, so you will need to
run this process on another machine (or on a USB SD adaptor on your chumby).


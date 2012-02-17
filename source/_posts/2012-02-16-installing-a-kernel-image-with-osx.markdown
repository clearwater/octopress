---
layout: post
title: "Installing a Kernel Image with OSX"
date: 2012-02-16 15:29
comments: true
categories: 
---

Insert the microSD in the SD adaptor and insert it into the SD 
slot on your Mac.  You will get a popup warning saying ```The disk you
inserted was not readable by this computer.```  Click Ignore.

Use diskutil to find the device name.  Look for the 1GB disk 
with 4 Linux partitions.  If you missed the instructions above and
clicked Eject instead, it will not be listed here.

```
$ diskutil list
/dev/disk0
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *1.0 GB     disk0
   1:                       0x53                         150.2 MB   disk0s1
   2:                      Linux                         128.0 MB   disk0s2
   3:                      Linux                         128.0 MB   disk0s3
   4:                      Linux                         128.0 MB   disk0s5
   5:                      Linux                         614.5 MB   disk0s6
/dev/disk1
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *320.1 GB   disk1
   1:                        EFI                         209.7 MB   disk1s1
   2:                  Apple_HFS Macintosh HD            319.7 GB   disk1s2
```

In my case this identifies the device as ```/dev/disk0```.  Unmount the disk.
```
$ diskutil unmountDisk /dev/disk0
Unmount of all volumes on disk0 was successful
```

Copy the ROM image to the SD as follows:
```
sudo dd if=rom-chumby-falconwing-chumby-starter-image.img of=/dev/disk0 bs=8m
```

Be patient, this takes a while... like 6 and a half minutes in my case.  Perhaps you would like to amuse youself by looking at [pictures of cats](http://squee.icanhascheezburger.com/)?

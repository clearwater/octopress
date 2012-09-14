---
layout: post
title: "Analog Gauges Using i2c on the Raspberry Pi"
date: 2012-09-14 15:49
comments: true
categories: "raspberrypi"
---

{% img right http://guy.carpenter.id.au/gaugette/resources/thermo_backlit.png %}

As part of the [Gaugette](http://guy.carpenter.id.au/gaugette) project, I've been
intending to try driving Switec X25.168 motors using the MCP23008 i2c I/O port
expander chip.  However it occurs to me that it might be more interesting
to demonstrate this on the [Rasberry Pi](http://www.raspberrypi.org).  If it works, it will demonstrate
a simple and very inexpensive method for driving analog gauges from the Raspberry Pi without
the need for stepper drivers.

The plan is to wire up the I/O expander chip
to a Raspberry Pi using i2c and to port the 
[Switec X25 library](https://github.com/clearwater/SwitecX25)
to run on the Pi.

The MCP23008 ([datasheet here](/resources/2012-09-14/MCP23008.pdf)) 
is rated to source and sink 20mA, which is half that of an Arduino, but should
be (just) enough to drive a Switec.
These chips are available [from Adafruit](http://www.adafruit.com/products/593),
who also now carry an awesome [16-port version](http://www.adafruit.com/products/732).
And they are cheap as, well, chips.

This first article covers connecting the MCP23008 to the Pi and verifying the i2c connection.

Step 1 - Installing AdaFruit's Kernel Image
------

Adafruit have prepared a modified version of the Wheezy Linux distribution for the Pi that includes i2c tools
and drivers (plus SPI, one wire, and plenty of other hackable goodness.)  The first step is to replace the
vanilla Wheezy disk image with Adafruit's Occidentalis image.

Insert a 4GB SD card and figure out it's device name using
`diskutil list`.  It is easy to recognise the SD card in the list below as `/dev/disk2`
because of the 4GB size.

{% codeblock %}

euramoo:misc guy$ diskutil list
/dev/disk0
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                         320.1 GB   disk0
   1:                        EFI                         209.7 MB   disk0s1
   2:                  Apple_HFS Macintosh HD            319.2 GB   disk0s2
   3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3
/dev/disk1
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     Apple_partition_scheme                         12.3 MB    disk1
   1:        Apple_partition_map                         32.3 KB    disk1s1
   2:                  Apple_HFS Flash Player            12.3 MB    disk1s2
/dev/disk2
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                         4.0 GB     disk2
   1:             Windows_FAT_32                         58.7 MB    disk2s1
   2:                      Linux                         3.9 GB     disk2s2

{% endcodeblock %}

Next unmount the disk with `diskutil unmountDisk`.

{% codeblock %}
$ diskutil unmountDisk /dev/disk2
Unmount of all volumes on disk2 was successful
{% endcodeblock %}

Download Occidentalis from [AdaFruit](http://learn.adafruit.com/adafruit-raspberry-pi-educational-linux-distro).
I'm using [Version 0.2](http://learn.adafruit.com/adafruit-raspberry-pi-educational-linux-distro/occidentalis-v0-dot-2).
Unzip it, verify the checksum, and copy it to the SD card.  This a big file, but I was still surprised it took half an hour
to write to the SD card.

{% codeblock %}
$ mv ~/Downloads/Occidentalisv02.zip .

$ unzip Occidentalisv02.zip 
Archive:  Occidentalisv02.zip
  inflating: Occidentalis_v02.img    

$ shasum Occidentalis_v02.img
a609f588bca86694989ab7672badbce423aa89fd  Occidentalis_v02.img

$ sudo dd bs=1m if=Occidentalis_v02.img of=/dev/disk2
Password:
...time passes
2479+1 records in
2479+1 records out
2600000000 bytes transferred in 2099.207512 secs (1238563 bytes/sec)
{% endcodeblock %}

Step 2 - Test the Boot Image
-----

Boot the Pi from the newly copied SD image and log in.  The default username is 'pi', password 'raspberry'.  DHCP and ssh are enabled by default
so you can login headless if you can figure out the IP address from the DHCP server.

Confirm that the i2c tools are installed and working by doing an i2c
scan of bus 0.  You should see nothing on the bus, as shown below.

{% codeblock %}

pi@raspberrypi ~ $ sudo i2cdetect -y  0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --   

{% endcodeblock %}

Step 3 - Wire Up
----

The Raspberry Pi expansion port pinout is as follows:

{% img /resources/2012-09-14/raspberrypi.png %}

The MCP23008 pins are as follows

{% img /resources/2012-09-14/MCP23008.png %}

There are 4 wires connect the Pi to the MCP23008:

 - SDA Pi pin 3 to MCP23008 pin 2
 - SCL Pi pin 5 to MCP23008 pin 1
 -  5V Pi pin 2 to MCP23008 pin 18
 - GND Pi pin 6 to MCP23008 pin 9

Note that I'm powering the chip from 5V instead of the 3.3V because
I want to power the motor windings at 5V.  There is 
apparently no problem connecting 3.3V and 5V circuits over i2c.
Time will tell if the Pi's power supply can handle the load and
noise introduced by the Switec stepper motors.

In addition you MUST make the following connections on the chip.  *You cannot let these float!*
Well you can, but you will get i2c read errors if you do.

 - MCP23008 address pins 3,4,5 to Vdd or Vss to set the bus address.
 - MCP23008 reset pin 6 to Vdd.  Pull it high.

You do not need current limiting resistors on the address or reset pins and the Pi 
has built-in pull-up resistors on SDA and SCL so you do not need to provide them.

The i2c 7-bit address will be binary `[ 0 0 1 0 A2 A1 A0 ]` so
if all address lines are pulled to ground it will be at 0x20, if they
are all high, it will be at 0x27.  i2c addresses are sometimes confusingly 
left-shifted 1 bit and expressed as 8-bit addresses,  which are 2x the 7-bit
address, like this `[ 0 1 0 A2 A1 A0 0 ]`.  Can't we all just get along?
Side note - if you are reading i2c protocol diagrams, know that i2c sends MSB first.

Step 4 - Probe!
----

Power up and repeat the `i2cdetect` command.  This time you should
see device on the bus!  Mine is at 0x20 because I pulled all of the
address lines to ground.

{% codeblock %}

pi@raspberrypi ~ $ sudo i2cdetect -y  0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         

{% endcodeblock %}

You can read the IODIR register (0) which should return all 1's
(all pins configured as inputs), and the OLAT register (10 or 0xA) which should return all 0's.

{% codeblock %}
pi@raspberrypi ~ $ sudo i2cget -y 0 0x20 0
0xff
pi@raspberrypi ~ $ sudo i2cget -y 0 0x20 10
0x00

{% endcodeblock %}


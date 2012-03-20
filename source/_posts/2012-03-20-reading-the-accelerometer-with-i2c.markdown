---
layout: post
title: "Reading the Accelerometer With I²C"
date: 2012-03-20 13:47
comments: true
categories: 
---

The CHB has an on-board Freescale MMA7455L 3-axis accelerometer, [datasheet here](http://www.freescale.com/files/sensors/doc/data_sheet/MMA7455L.pdf), which can be accessed over the [I²C](http://en.wikipedia.org/wiki/I2C) bus.
Not long after the Chumby Hackers Board was released
Adafruit published [a tutorial](http://www.ladyada.net/learn/chumby/i2c.html)
explaining how to access the accelerometer over i2c.

I've added some i2c tools to the OpenEmbedded image, so as well 
as compiling the tools in the Adafruit tutorial, 
you can use the packaged i2c tools (i2cdetect, i2cget, i2cset, i2c) 
to talk to the accelerometer.

i2cdetect
---------

The ```i2cdetect``` tool will give you information about
the i2c bus device:

```
root@chumby-falconwing:~# i2cdetect -l
i2c-0   i2c             378x I2C adapter                        I2C adapter
```

```
root@chumby-falconwing:~# i2cdetect -F 0
Functionalities implemented by /dev/i2c-0:
I2C                              yes
SMBus Quick Command              no
SMBus Send Byte                  yes
SMBus Receive Byte               yes
SMBus Write Byte                 yes
SMBus Read Byte                  yes
SMBus Write Word                 yes
SMBus Read Word                  yes
SMBus Process Call               yes
SMBus Block Write                yes
SMBus Block Read                 no
SMBus Block Process Call         no
SMBus PEC                        yes
I2C Block Write                  yes
I2C Block Read                   yes
```

Enable the Accelerometer
------------------------

The accelerometer is at bus address $1d (decimal 29).  The 
Adafruit tutorial explains that i2c encodes
7-bit addresses in the high 7 bits, so we shift this up 1 bit
giving an effective address of 58.

Register $16 (decimal 22) controls the mode of the accelerometer
and at power-up it is in standby mode.  The lower two
bits set the mode as follows:

 - 00 : standby mode
 - 01 : measurement mode
 - 10 : level detection mode
 - 11 : pulse detection mode

The next two bits define the sensitivity:

 - 00 : 8g range, 16 LSB/g
 - 01 : 2g range, 64 LSB/g
 - 10 : 4g range, 32 LSB/g

So put it into measurement mode, 2g range, we write
0000 0101 binary (5 decimal) to register $16 (decimal 22)
at bus address 58.

```
root@chumby-falconwing:~# i2c 58 wb 22 5
```

The easiest way to read the accelerometer data is
to use the mma7455.c example from the Adafruit tutorial.
For convenience you can download the file from [here](https://raw.github.com/gist/2131304/8ccc68a8725347e2a5fcebaf259ac75eb2d0113b/mma7455.c).

<script src="https://gist.github.com/2131304.js?file=mma7455.c"></script>

Save that file as ```mma7455.c```, and Compile it as follows:

```
root@chumby-falconwing:~# gcc -o mma7455 mma7455.c
```

When you run the compiled binary, you should see something like this:

```
root@chumby-falconwing:~# ./mma7455
X = -5  Y = -15 Z = 67
X = -6  Y = -15 Z = 65
X = -6  Y = -15 Z = 65
X = -6  Y = -15 Z = 65
X = -6  Y = -15 Z = 65
X = -6  Y = -15 Z = 65
X = -5  Y = -15 Z = 68
X = -5  Y = -15 Z = 68
```

Now pick up the device and wave it at your
office-mates.  Watch the numbers change.
Say woo-hoo.

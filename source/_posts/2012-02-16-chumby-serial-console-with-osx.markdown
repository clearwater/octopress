---
layout: post
title: "Chumby Serial Console Under OSX"
date: 2012-02-16 15:06
comments: true
categories: 
---

This assumes you already have

 - a [3.3v FTDI cable](http://www.adafruit.com/products/70) from AdaFruit
 - modified the cable as per [the AdaFruit tutorial](http://www.ladyada.net/learn/chumby/serial.html).
 - connected it to the OSX machine

To determine the device name:

```
$ ls /dev/tty.*
/dev/tty.Bluetooth-Modem        /dev/tty.iphone-SerialPort1
/dev/tty.Bluetooth-PDA-Sync     /dev/tty.usbserial-FTF7VKP4
```

The device name starting with ```tty.usbserial``` is the one we are looking for.

To make a connection using ```screen``` at 152000 baud:

```
screen /dev/tty.usbserial-FTF7VKP4 115200
```

You should now have a full-screen console.  To exit, type ```ctrl-a ctrl-k```.  When you are asked ```Really kill this window [y/n]``` type ```y```.




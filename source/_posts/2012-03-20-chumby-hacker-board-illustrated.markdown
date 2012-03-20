---
layout: post
title: "Chumby Hacker Board Illustrated"
date: 2012-03-20 15:33
comments: true
categories:
---

Note that connection labels correspond to the identifiers on the [Version 1.0 schematics](http://files.chumby.com/hackerboard/falconwing_oem3.pdf).

Front of Board
==============

![Chumby Hackers Board Front](/resources/chumbyhackerboardfront.jpg)

JP300
-----
5VDC Power : Requires a regulated 5VDC power supply, positive tip, 
3.5mm OD, 1.4mm ID barrel jack (aka a 3.8mm or 4mm connector).

Schematics indicate 2A peak.  According to [AdaFruit](http://wiki.ladyada.net/chumbyhackerboard/power) the power draw for the subsystems is roughly:

 - 300 mA for the base hardware (processor, RAM, SD card),
 - 200 mA for the USB hub (not including power to the USB devices),
 - 300 mA for a speaker plugged into the 2W output,
 - 500 mA max for charging a Lipoly battery.

P102
----
Serial JTAG header - 0.1" male header (DNP)

 - Pin 1 : 3.3v
 - Pin 2 : DEBUG
 - Pin 3 : PSWITCH
 - Pin 4 : GND

P406
----
PWM2 : Pulse Width Modulation

 - Pin 1 : GND
 - Pin 2 : PWM2 (CPU)
 
P400
----
LRADC1 : Low Resolution Analog to Digital Converter

 - Pin 1 : LRADC1 (CPU)
 - Pin 2 : connected to pin 39 of P401 (why?)

P104
----
Rotary Quadrature Encoder (no connector, solder points only)

 - Pin 1 : ROTARYA
 - Pin 2 : GND
 - Pin 3 : ROTARYB

P200
----
9x2 header : USB, I2C and GPMI

The following signals are available (by pin number)

 - 1 - 5V
 - 3 - USBC1 N
 - 5 - USBC1 P
 - 7 - GND
 - 9 - Vid to Ext
 - 10 - i2C SCL
 - 11 - i2C SDA
 - 15 - 3.3V
 - 17 - LCD XP
 - 19 - LCD YP
 - 21 - LCD XM
 - 23 - LCD YM
 - 25 - HOST TO CP UART

 - 2 - GPMI D00
 - 4 - GPMI D01
 - 6 - GPMI D02
 - 8 - GPMI D03
 - 10 - GPMI D04
 - 12 - GPMI D05
 - 14 - GPMI D07
 - 16 - GPMI D06
 - 18 - OSC TO FM
 - 20 - PWM2
 - 22 - CHUMBY BEND
 - 26 - CP TO HOST UART

P100
----
Li-poly battery connector : JST B3B-EH-A connector.  

If powering from a Li-poly, USB0 will be powered, 1 and 2 will not.  
There is a fourth USB connection on the GPIO header which is
also powered by the Li-poly boost system. 
[ref](http://wiki.ladyada.net/chumbyhackerboard/power#lithium_battery)

P500
----
USB2 : USB Type A Female

P503
----
USB1 : USB Type A Female (is this really USB4?) 

Note that the power to this port (and P500?) is software controlled and may be off at power-up.  It can be enabled as explained [here.](http://forum.chumby.com/viewtopic.php?pid=36906#p36906)

---
layout: post
title: "Controlling an Adafruit SSD1306 SPI OLED with a Raspberry Pi"
date: 2012-11-08 10:31
comments: true
categories: 
---

{% img right /resources/2012-11-08/ssd1306.jpg %}
 
Adafruit's lovely little [128x32 monochrome SPI OLED module](http://www.adafruit.com/products/661)
uses a SSD1306 driver chip ([datasheet](http://www.adafruit.com/datasheets/SSD1306.pdf)),
and Adafruit have published [excellent tutorials](http://learn.adafruit.com/monochrome-oled-breakouts) and
[libraries](https://github.com/adafruit/Adafruit_SSD1306) for driving this from an Arduino.

When asked in [their their forum](http://adafruit.com/forums/viewtopic.php?f=47&t=33040)
about Raspberry Pi support, Adafruit have said
that _there is a huge backlog of libraries to port to the RasPi and (they) don't have any ETA on the SSD1306_.

I'm working on a new build that was originally intended for an Arduino, but I've decided to
switch to the Raspberry Pi, so I need to get this display working with the Pi.
I've partially ported Adafruit's SSD1306 library to Python for the Raspberry Pi.  The port is partial
in that:

 1. it only supports the 128x32 SPI module (unlike the original that supports the I&sup2;C and 128x64 modules) and 
 2. only supports pixel and text drawing functions (no geometric drawing functions).

Signal Levels
-------------

The Adafruit module has built-in level-shifters for 5V operation.  I wasn't entirely confident
from what I read online that the module would work unmodified at 3.3V, but the module
silkscreen says very clearly 3.3 - 5V.  I can confirm it works very happily with
both Vin and signalling at 3.3V.

SPI Signals
-----------

In SPI nomenclature MISO is _master in, slave out_, MOSI is _master out, slave in_.
The SSD1306 module is write-only using SPI, and so there is no MISO connection available on the module,
and __MOSI is labelled DATA on the module__.
If you leave MISO on the RPi disconnected it will be pulled low so all input is zeroed, which is fine.

The __D/C__ (Data/Command) signal on the module is not part of the SPI interface, and it took a little
experimenting to understand exactly what it is used for.  Initially I supposed _data_ to include the
argument bytes that follow the opcode when sending multi-byte commands.  For example the "Set Contrast Control"
command consists of a one-byte opcode (0x81) followed by a one-byte contrast value, so I was sending
the first byte with D/C high, and pulling it low for the argument byte.  Wrongo!  That's not what they
mean by _data_; __keep the D/C line high for all bytes in a command, and pull it low 
when blitting image data into the image memory buffer__.  Simple enough, once said.

Platform
--------

I'm running Python 2.7.3 on a Rasberry Pi Model B (v1) with the following software:

 - [Occidentalis 0.2](http://learn.adafruit.com/adafruit-raspberry-pi-educational-linux-distro/occidentalis-v0-dot-2) boot image,
 - [WiringPi-Python](https://github.com/WiringPi/WiringPi-Python) for python access to the GPIO pins,
 - [py-spidev](https://github.com/doceme/py-spidev) for python bindings to the spidev linux kernel driver.

Wire Up
-------

Here's how I've wired it up.  You can use any free GPIOs for
D/C and Reset.
{%img /resources/2012-11-08/raspberrypi_and_ssd1306.png %}

Test Code
----

__Note that pin numbers passed in the constructor are
the [wiring pin numbers](https://projects.drogon.net/raspberry-pi/wiringpi/pins/),
not the connector pin numbers!__ 

For example I have Reset wired to connector pin 8, which is _BCP gpio 15_, but _wiringPi pin 15_.
It's confusing, but just refer to the [wiringPi GPIO table](https://projects.drogon.net/raspberry-pi/wiringpi/pins/).

The python library for the SSD1306 has been rolled into the 
[py-gaugette library](https://github.com/guyc/py-gaugette) available on github.

The test code below vertically scrolls vertically between two display buffers, one
showing the current time, one showing the current date.

{% youtube 6Ik7lDBoKz8 %}

This sample code is [included in the py-gaugette library](https://github.com/guyc/py-gaugette/blob/master/samples/ssd1306_test.py).

```
import gaugette.ssd1306
import time
import sys

RESET_PIN = 15
DC_PIN    = 16

led = gaugette.ssd1306.SSD1306(reset_pin=RESET_PIN, dc_pin=DC_PIN )
led.begin()
led.clear_display()

offset = 0 # buffer row currently displayed at the top of the display

while True:

    # Write the time and date onto the display on every other cycle
    if offset == 0:
        text = time.strftime("%A")
        led.draw_text2(0,0,text,2)
        text = time.strftime("%e %b %Y")
        led.draw_text2(0,16,text,2)
        text = time.strftime("%X")
        led.draw_text2(8,32+4,text,3)
        led.display()
        time.sleep(0.2)
    else:
        time.sleep(0.5)
        
    # vertically scroll to switch between buffers
    for i in range(0,32):
        offset = (offset + 1) % 64
        led.command(led.SETSTARTLINE | offset)
        time.sleep(0.01)
```


About Fonts
-----------

{% img right /resources/2012-11-08/steve-jobs-does-not-approve.jpg %}

This test code uses the 5x7 bitmap font from the 
[Adafruit GFX library](https://github.com/adafruit/Adafruit-GFX-Library/blob/master/glcdfont.c)
scaled to x2 and x3.  I have not added
any spacing between characters either.  It works, but __Steve Jobs would
not approve!__  It isn't taking advantage of the very high resolution of these
lovely little displays.  Larger fonts with kerning would be a great addition.





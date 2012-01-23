---
layout: post
title: "What is Gaugette?"
date: 2012-01-05 13:11
comments: true
categories: arduino switec x25
---

Gaugette is an Arduino library for controlling Switec X25.168 stepper motors
directly from the Arduino data IO lines.  Each motor requires 4 digital IO pins,
and a single arduino can drive multiple motors.

<iframe width="560" height="315" src="http://www.youtube.com/embed/Z-f4m18n48I" frameborder="0" allowfullscreen></iframe>

The source code for the library, and some sample client code is available from the
[GitHub repository](https://github.com/clearwater/gaugette).

Motivation
----------

After playing with the
[motor shield party pack](http://www.adafruit.com/products/171) from Adafruit,
I started thinking it would be fun to have a couple of analog gauges
mounted on the wall somewhere to show system health indication; maybe network bandwidth or
web traffic?  Of course I've seen the very beautiful 
[TorrentMeter by Skytee](http://blog.skytee.com/2010/11/torrentmeter-a-steampunk-bandwidth-meter/)
which just makes me weep, but I don't have a beautiful brass antique voltmeter to go that route.

The servos and steppers in the Adafruit pack aren't ideal for driving gauges.  The little stepper they 
include runs really hot.  The servo seemed
like possibility and it is driven by PWM, so I wouldn't even need the motor shield.
But it is quite bulky and noisy, so I started looking for something better.

The Switec X25 Stepper Motor
----------------------------

<img alt="Switec X26.168 Stepper Motor" src="/resources/Switec_X25_168.jpg" align="right">
I noticed a lot of sellers on ebay selling tiny Switec X25
motors as replacements for GM auto instrument clusters.  They were developed 
by the technology arm of Swatch, so I figured they should be low power and
pretty quiet.  Certainly they are cheap; under $5 each!  

The X25 motors have 6 steps per revolution, and a 180:1 gearbox, giving a
resolution of 1/3 degree.
The [spec sheet](X25_xxx_01_SP_E-1.pdf)
indicates they draw no more than 20mA per winding, which is low enough to source directly from the 5V
Arduno data pins, raising the possibility of driving these without an intermediate controller chip. Yes, I 
understand the risks associated with wiring inductive loads directly to the microcontroller.  Arduinos are
cheap, why not try it?

On the net I found an excellent 
[overview of the Switech X25 by Mike Powell](http://www.mycockpit.org/forums/content.php/355-An-Easy-Approach-to-an-Analog-Gauge).
Mike expresses concerns about driving inductive loads directly from the microcontroller and uses
an external L293D driver.  There is an intruiging 
[thread by Toby Catlin](http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1260978962)
which approaches the issue of driving these without a controller, but the thread ends abruptly at the point
where he sees the first signs of success.  What happens next?  Blue smoke?

At the price I figured it was worth a shot driving these directly, 
so I ordered 6 from  [one of many](http://stores.ebay.com.au/partsangel)
ebay stores selling them.  Apparently a complete GM instrument cluster has 6 motors, so 6 is a popular quantity.
In all it cost about $25 including postage from the US to Australia.
At the time of writing they carry both the X25.168
with rear contacts, and the X25.589 with front contacts and a longer indicator shaft.
Both have internal stops.  See the [buyers guide](/resources/ISM_Buyers_Guide.pdf) for details
on the different models.







---
layout: post
title: "What is Gaugette?"
date: 2012-01-05 13:11
comments: true
categories: Arduino Switec x25
---

Gaugette is a project detailing the construction of custom analog gauges using
an Arduino microcontroller and Switec X25.168 stepper motors. 
Each motor requires 4 digital I/O pins,
and a single Arduino can drive three motors.  The limit
is purely due to Aruidno limit of 14 digital I/O lines.

{% youtube Z-f4m18n48I %}

Source code for the project is available on 
[GitHub](https://github.com/clearwater/gaugette).

Motivation
----------

After playing with the
[motor shield party pack](http://www.adafruit.com/products/171) from Adafruit,
I started thinking it would be fun to have a couple of analog gauges
mounted on the wall somewhere to show system health indication; maybe network bandwidth or
web traffic? 
{% img right http://blog.skytee.com/wp-content/uploads/2010/11/B-300x277.jpg TorrentMeter by Skytee %}
Of course I've seen the very beautiful 
[TorrentMeter by Skytee](http://blog.skytee.com/2010/11/torrentmeter-a-steampunk-bandwidth-meter/)
which is so pretty it makes me weep, but beautiful brass antique voltmeters are in short supply 
around here.

The servos and steppers in the Adafruit pack aren't ideal for driving gauges.  The little stepper they 
include runs really hot.  The servo seemed
like possibility and it is driven by PWM, so I wouldn't even need the motor shield.
But it is quite bulky and noisy, so I started looking for something better.

The Switec X25 Stepper Motor
----------------------------

{% img right /resources/Switec_X25_168.jpg Switec X26.168 Stepper Motor %}
I noticed a lot of sellers on eBay selling tiny Switec X25
motors as replacements for GM auto instrument clusters.  They were developed 
by the technology arm of Swatch, so I figured they should be low power and
pretty quiet.  Certainly they are cheap; under $5 each!  

The X25 motors have 6 steps per revolution, and a 180:1 gearbox, giving a
resolution of 1/3 degree.
The [data sheet](/resources/switec/X25_xxx_01_SP_E-1.pdf)
indicates they draw no more than 20mA per winding, which is low enough to source directly from the 5V
Arduino data pins, raising the possibility of driving these without an intermediate controller chip. Yes, I 
understand the risks associated with wiring inductive loads directly to the microcontroller.  Arduinos are
cheap, why not try it?

On the net I found an excellent 
[overview of the Switec X25 by Mike Powell](http://www.mycockpit.org/forums/content.php/355-An-Easy-Approach-to-an-Analog-Gauge).
Mike expresses concerns about driving inductive loads directly from the microcontroller and uses
an external L293D driver.  There is an intriguing 
[thread by Toby Catlin](http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1260978962)
which approaches the issue of driving these without a controller, but the thread ends abruptly at the point
where he sees the first signs of success.  What happens next?  Blue smoke?

At the price I figured it was worth a shot driving these directly, 
so I ordered 6 from  [one of many](http://stores.ebay.com.au/partsangel)
eBay stores selling them.  Apparently a complete GM instrument cluster has 6 motors, so 6 is a popular quantity.
In all it cost about $25 including postage from the US to Australia.
At the time of writing they carry both the X25.168
with rear contacts, and the X25.589 with front contacts and a longer indicator shaft.
Both have internal stops.  See the [buyers guide](/resources/switec/ISM_Buyers_Guide.pdf) for details
on the different models.







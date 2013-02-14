---
layout: post
title: "X12 Quad Driver Chip"
date: 2012-01-19 17:10
comments: true
categories: 
---
{% img right /resources/X12_Quad_Driver.png Switec X12.017 Quad Driver %}
The [X25 data sheet](/resources/switec/X25_xxx_01_SP_E-1.pdf)
describes the X12 family of driver chips which allow
up to 4 Switec motors to be controlled over a 3-wire serial interface.
I like the look of these for keeping the I/O count down, and offloading
a bunch of processing from the Arduino.

However I have been unable to find a supplier for X12 quad driver chips.
It seems that they were available until recently
from Swatch subsidiary Microcomponents Ltd. at microcomponents.ch,
but after Swatch 
[sold the stepping motor business](http://www.swatchgroup.com/en/services/archive/2009/swatch_group_sale_of_microcomponents_automotive_business_activities_to_juken_technology)
to Singapore-based [Juken Techonology](http://www.jukenswisstech.com) in 2009, 
that website disappeared.

There appear to be several other manufacturers making clones of this chip.  Here's what I've found so far:

 - The original Switec X12.017 Quad Driver [(datasheet)](/resources/switec/X12_017.pdf)
 - The VID VID6606 Quad Driver [(datasheet)](/resources/vid/2009111391612_VID6606%20manual%20060927.pdf)
 - The [NOST Microelectronics](http://www.nostm.com) BY8920  Quad Driver [(datasheet, in Chinese)](/resources/nost/1428412011616by8290datasheet.pdf), [datasheet translated to English by Google](http://translate.google.com.au/translate?hl=en&sl=zh-CN&tl=en&u=http%3A%2F%2Fguy.carpenter.id.au%2Fgaugette%2Fresources%2Fnost%2F1428412011616by8290datasheet.pdf).
 - The AX1201728SG was suggested in the comments.  I have not been able to locate a datasheet, but unlike any of the other chips listed here, these are available in single quantity on ebay.  The SG is a SOP (Small Outline Package) surface mount IC.  I believe the DIP version of this chip is the AX1201728PG.

NOST also manufacture the[BY8291, a 16-pin dual driver](/resources/nost/17641201167by8291datasheet.pdf).

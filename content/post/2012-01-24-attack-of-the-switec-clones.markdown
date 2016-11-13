---

title: "Attack of the Switec Clones?"
date: "2012-01-24T09:29:00+10:00"

categories:
 - Switec X25
---
{{< img src="/resources/X25_clone.png" pos="right" label="Switec Clones" >}}
When my eBay Switec X25.168 motors arrived, they didn't look at all like
the white motors with the "Switec" branding that I've been seeing
online.  I finally got around to tracking down what exactly they are.
They have two identification numbers printed black on black:
``vid29-02p`` and ``d11455db``.
<!--more-->
{{< img src="/resources/VID29_diagram.png" pos="right" label="Motor Diagram" >}}
It turns out that the first number is the model, and these are in reality VID29 series stepper motors
from [Hong Kong VID](http://www.vid.wellgain.com/product.aspx).  Interestingly their
{{< xref src="/resources/vid/20091026113525_VID29_manual_EN-080606.pdf" label="data sheet" >}}
includes details of recommended acceleration characteristics to bring the motors
to full speed without visible and audible jitter.  Cool cool cool.

Armed with that information
I turned up what appears to be a third manufacturer, [MCR Motor](http://www.mcrmotor.com/en/) who
call this motor the MR1108.  The MCR {{< xref src="/resources/mcr/2010410104720473.pdf" label="data sheet" >}}
lists the Switec and VID motors as alternatives.

The eBay seller had these marked unambiguously as X25.168 motors in their auction, but didn't
specifically say they were from Switec.  I wonder if any of the eBay offers are actual Switec motors?

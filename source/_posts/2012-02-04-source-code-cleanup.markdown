---
layout: post
title: "Separation Anxiety"
date: 2012-02-04 11:38
comments: true
categories: 
---
{% img right /resources/dial_parts.png Separation Anxiety %}
I've separated the Switec X25 motor driver code into a separate
library repository on GitHub.  This will make it easier to use
the driver library in other applications.

[SwitecX25 Library](https://github.com/clearwater/SwitecX25)
--------
This contains only the Switec X25 driver.

[Gaugette](https://github.com/clearwater/gaugette) 
--------
This is an arduino application that controls analog
gauges by interpreting commands received over the serial interface.
To compile Gaugette you will now need to add the SwitecX25 library 
to your Arduino libraries folder.


   





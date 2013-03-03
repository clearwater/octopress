---
layout: page
title: "About Gaugette"
date: 2012-02-08 14:08
comments: true
sharing: true
footer: true
---

What is Gaugette?
-----------------

{% img right /resources/thermo_backlit.png LED Backlighting %}
Gaugette is a blog detailing the construction of custom gauges
and gadgets using Arduino microcontrollers or Raspberry Pis.

It was originally created to document the creation of analog gauges using
Switec X25 stepper motors, but the focus is now broader; it turns out
not every gadget needs an analog gauge.  Go figure.

What is a Switec X25?
---------------------
I've chosen Switec X25.168 miniature
stepper motors to drive the gauges.  These steppers
were developed by Switec, the Swatch Company's technology arm,
for automobile instrument clusters. They are really cheap, readily available
and require no external driver circuitry.  Pretty cool huh?

Because information about driving these motors with the Arduino is hard to find,
I've gathered the datasheets and other [resources here](/resources), 
and have published a
[Arduino SwitecX25 driver library](https://github.com/clearwater/SwitecX25)
on GitHub.

{% img right /resources/gauge_pair.jpg Mounted Gauges %}

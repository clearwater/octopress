---
layout: post
title: "LED Gauge Backlighting"
date: 2012-02-11 17:14
comments: true
categories: 
---
{% img right /resources/thermo_backlit.png LED Backlighting %}

Today I added an LED backlight to my square gauge.

I used a white LED which was originally part
of a solar-powered LED light string.  These are side-emitting
LEDs; they have a conical well in the lens that refracts much
of the light sideways, which is useful in this application.

I mounted the LED and a current-limiting resistor inside the
back of the case.  The cathode is driven by a PWM pin on the
Arduino, so the brightness is under software control.

{% img left /resources/thermo_led.png with face removed %}

The effect is quite pleasing.  I particularly like how light leaks from the 
grills at the top and bottom of gauge.

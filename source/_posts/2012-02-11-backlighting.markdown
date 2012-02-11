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
of the light sideways.  I tried changing the diffusion pattern
by re-cutting the lens and applying hot glue, but I didn't come
up with anything I liked better than the natural pattern.

I mounted the LED and a current-limiting resistor inside the
back of the case.  The cathode is driven by a PWM pin on the
Arduino so the brightness can be controlled in software.

{% img left /resources/thermo_led.png with face removed %}

The effect is quite pleasing.  I like how light leaks from the 
grills at the top and bottom of gauge.

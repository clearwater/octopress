---
layout: post
title: "Two Motors, One Arduino"
date: 2012-01-23 14:39
comments: true
categories: 
---

Last night I built a pair of improved wiring harnesses so I could
connect two motors to the Arduino.  Once concern
I have is that the control logic that manages the acceleration and
deceleration could be so slow that it will interfere with the motor
drive signalling when trying to control more than one motor.  I have in mind to replace the
floating point logic with a lookup table, but for now I like being
able to easily fiddle with the motion parameters.

It turns out that two motors work pretty well with only minor tweaks to the existing
code.

<iframe width="560" height="315" src="http://www.youtube.com/embed/Z-f4m18n48I" frameborder="0" allowfullscreen></iframe>

---
layout: post
title: "Motor Acceleration and Deceleration"
date: 2012-01-15 19:38
comments: true
categories:
 - Switec X25
 - Arduino
---

My first cut at the [Switec X25 library](https://github.com/clearwater/gaugette)
stepped the needle at a constant speed.  You can see the constant speed
motion in the [original video](http://www.youtube.com/watch?v=vwAxRk_5oXA).

{% youtube uNLySm71OBc %}

I've updated the library to support acceleration and deceleration, partly because
it seems more aesthetically pleasing, and partly because I have a notion that
I should be able to reach faster peak speeds by ramping the speed up.  Motion is
now specified by 4 parameters: minimum speed, maximum speed, acceleration, deceleration.

For now I've used floating point calculations to compute each step period
standard Newtonian velocity/distance/time
calculations.  This works okay, but is unnecessarily compute-intensive.

The Switec X25 library supports multiple motors
and no doubt this computation will become a factor when I try to drive more than
one motor, so I'll have to address that at some point. 

One interesting aspect of the control logic is that the calculations are done at the start
of each step, in distance-domain rather than in time domain like most simulations.
This means the calculations must be done more frequently at higher needle
speeds.  This is going to set an upper bound on maximum step rate.

When it does become an issue, 
I think I could replace the entire floating point calculation with a small table of pre-computed
(step-count, step-period) pairs with little perceptible difference.

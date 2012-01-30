---
layout: post
title: "A Simplified Acceleration Model"
date: 2012-01-26 09:42
comments: true
categories: 
---
The logic in the advance() function of the Switec X25 library
steps the motor one step up or down, and computes the delay in 
microseconds until the next step.  This logic determines the acceleration,
deceleration and maximum speed of the needle.  My first cut at this
code used floating point arithmetic to simulate Newtonian physics.  It's
overkill, and consumes too many precious Arduino compute cycles.  When
driving multiple motors, this could create an artificial ceiling on the
maximum motor speed.

I've rewritten that logic to use a simple lookup table instead.
This is a fairly obvious approach, but it was
reassuring to see similar approaches recommended in both the
[VID 29 documentation](/resources/vid/2009111395111_Acceleration_&_reset_calculation_example.pdf)
and the [MCR MR1107 data sheet](/resources/mcr/2010410104915847.pdf).

The acceleration curve is defined as pairs of vel,delay values:

<pre><code>unsigned short accelTable[][2] = {
  {   10, 5000},
  {   30, 1500},
  {  100, 1000},
  {  150,  800},
  {  300,  600}
};
</code></pre>

The values in the first column are the number of steps
traveled under acceleration which is essentially a surrogate for velocity.
We maintain a variable ```vel``` that increments 
each step under acceleration, and decreases each step under deceleration.
For simplicity I've made the acceleration and deceleration curves identical
so they can share the same lookup table.

Now to determine the step delay at any given value of ```vel```, we find 
the first table entry such that ```accelTable[i][0] < vel```.  In practice this means that the
motor will step at 5000&micro;S intervals for 10 steps, then 1500&micro;S 
steps for the next 20 steps, 1000&micro;S for the next 70 steps, and so on.
The peak speed with a delay of 600&micro;S correlates to 1666Hz step rate
or about 500 degrees per second.

The acceleration table values are constrained by the 
the inertia of the needle attached to the motor.  The VID 29 data sheet
gives some recommendations for calculating these values, but I actually
didn't use them for the values I'm using - I experimented until I found
found values that work and look nice to me.

The [library on Github](https://github.com/clearwater/gaugette) now contains
the updated logic.


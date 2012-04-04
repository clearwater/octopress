---
layout: post
title: "Making Wiring Harnesses"
date: 2012-04-04 13:05
comments: true
categories: 
---
A quick note about wiring harnesses for these motors.
I've found it really handy to make harnesses from 4-wire CD audio
cables and breakaway headers.  I have heard that it is easy to
overheat these motors when soldering to their contacts, so I've
been using slip-on connectors made from recycled PC audio cables.

The cables I'm talking about have 4-pin JST connectors on each end, and are
used to connect the analog audio signal from a PC's internal CD player to the
motherboard or sound card. I have accumulated a bunch of
these over the years, so I'm glad to have a use for them.

I also use [0.1" breakaway headers from AdaFruit](https://www.adafruit.com/products/392).

![image](/resources/2012-04-04/imgp9227.jpg)

 - Chop the audio cable in half (each half makes one wiring harness),
 - Strip and tin the wires on the cut end,
 - Cut off a 4-pin section of breakaway header,
 - Solder the wires to the header _with the two black wires in the center positions_,
 - Protect the connections with heat-shrink tubing.

![image](/resources/2012-04-04/imgp9228.jpg)

 - Pull up the plastic tabs on the JST connector and slide the crimped terminator out of the block,
 - Use pliers to close the crimp connectors a little, but don't crush them entirely. The pins on the Switec motors are really small, so you need to squeeze it down a little to create a tight fit.

![image](/resources/2012-04-04/imgp9229.jpg)

You'll notice that these harnesses have two black wires, which would
normally be a bit annoying.  However it turns out that the wires to
pins 2 and 3 on the Switec motors are interchangable, so make them
black and you don't need to distinguish between them.

Wire your motor up like this:

 - 1 : white
 - 2 : black
 - 3 : black
 - 4 : red

Be careful not to bend the pins on the motors when you slide the
crimp connectors on.  Also note that the pins on the motor are flat, not round,
so the orientation of the crimp connector matters.

Finally, if you plug the header into an Arduino so that white is at
pin 4, and red is pin 7, you can define your motor in code like this:

```
SwitecX25 motor1(MOTOR_STEPS, 4,5,6,7);
```


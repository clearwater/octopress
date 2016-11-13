---

title: "Making Wiring Harnesses"
date: "2012-04-04T13:05:00+10:00"

categories:
 - Switec X25
---
A quick note about wiring harnesses for these motors.
I've found it really handy to make harnesses from 4-wire CD audio
cables.  My harnesses use push-on connectors at the motor end
so I never [accidentally cook the motor](http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1260978962) by soldering to the motor pins.

!{{< xref src="/resources/2012-04-04/imgp9232.jpg" label="image" >}}

<!--more-->

The cables I'm talking about have 4-pin JST connectors on each end, and are
used to connect the analog audio signal from a PC's internal CD player to the
motherboard or sound card. I have accumulated a bunch of
these over the years, so I'm glad to have a use for them.

I also use [0.1" breakaway headers](https://www.adafruit.com/products/392) and heatshrink tubing, both from AdaFruit.

!{{< xref src="/resources/2012-04-04/imgp9227.jpg" label="image" >}}

 - Chop the audio cable in half (each half makes one wiring harness),
 - Strip and tin the wires on the cut end,
 - Cut off a 4-pin section of breakaway header,
 - Solder the wires to the header _with the two black wires in the center positions_,
 - Protect the connections with heat-shrink tubing.

!{{< xref src="/resources/2012-04-04/imgp9228.jpg" label="image" >}}

 - Pull up the plastic tabs on the JST connector and slide the crimped terminator out of the block,
 - Use pliers to close the crimp connectors a little, but don't crush them entirely. The pins on the Switec motors are really small, so you need to squeeze it down a little to create a tight fit.

!{{< xref src="/resources/2012-04-04/imgp9229.jpg" label="image" >}}

You'll notice that these harnesses have two black wires, which would
normally be a bit annoying.  However it turns out that the wires to
pins 2 and 3 on the Switec motors are interchangable so you don't need to distinguish between them.

Wire your motor up like this:

Motor Pin | Wire Color | Arduino Pin
--------- | ---------- | -----------
1         | white      | 4
2         | black      | 5
3         | black      | 6
4         | red        | 7

Be careful not to bend the pins on the motors when you slide the
crimp connectors on.  Also note that the pins on the motor are flat, not round,
so the orientation of the crimp connector matters; if it is too tight or too lose, try rotating the connector 90 degrees.

Finally, if you plug the header into an Arduino so that white is at
pin 4, and red is pin 7, you can define your motor in code like this:

```
SwitecX25 motor1(MOTOR_STEPS, 4,5,6,7);
```

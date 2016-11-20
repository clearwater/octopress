---

title: "Pulling Out All The Stops"
slug: "pulling-out-the-stops"
date: "2012-04-04T09:58:00+10:00"

categories:
 - Switec X25
---

Or more accurately, filing off the stops.

Recently [Tim Hirzel asked](/about#comment-459699391) if I knew
of a source of motors without stops, or if the X25.168's could be
modified to remove the stops and open up the full 360 degrees of rotation.

Good question!  The {{< xref src="/resources" label="X25 Series Buyers Guide" >}} lists 6 models
of motors without stops, but a quick search turned up no suppliers
selling these in small volumes.

Okay, time to figure out if the stops can be removed.  Note that I'm working
on a VID-29 clone, not a genuine Switec X25.168 here.
There are 4 tiny screws that open the case revealing this:

{{< img src="/resources/2012-04-04/imgp9223.jpg" label="case opened" >}}

<!--more-->

The drive-shaft and attached gear sit loose and can be lifted out.  Flipping the
gear over reveals the mechanism for the stop; a raised trapezoidal bump on the gear face
that stops against a matching protrusion at the bottom of the case.

{{< img src="/resources/2012-04-04/imgp9225.jpg" label="stop exposed" >}}

I cut off the stop with a Stanley knife, and filed it flat with a small file.

{{< img src="/resources/2012-04-04/imgp9226.jpg" label="stop removed" >}}

Reassembly was easy, and bugger me, it works.

 {{< youtube kY2yiKImWJE >}}

In the video you can see the needle hesitates on each rotation.  This is because of the acceleration/deceleration
logic in the SwitecX25 library; I'm accelerating the motor from stop,
spinning 360 degrees, decelerating to a stop again, then repeating,
using code like this:

```
          for (int i=0;i<nLoops;i++) {
            motor->currentStep = 0;    
            motor->setPosition(360*3);
            while (!motor->stopped) motor->update();
          }
```

To keep the speed constant I need to prevent it coming to a stop.
I can do that by resetting the origin and destination before
it reaches its goal step, like this:

```
          for (int i=0;i<nLoops;i++) {
            motor->currentStep = 0;         // reset origin on each rotation
            motor->setPosition(320*3*2);    // set target to way past end of rotation
            while (motor->currentStep<360*3) motor->update();  // turn until rotation is complete
          }
```

Or to run the motor in reverse:

```
          for (int i=0;i<nLoops;i++) {
            motor->currentStep = 360*3*2;
            motor->setPosition(0);
            while (motor->currentStep>360*3) motor->update();
          }
```

I think the SwitecX25 library will need some extensions to support stop-less motors...  need to
think about that a bit.

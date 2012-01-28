---
layout: post
title: "Gauge Build Number One"
date: 2012-01-28 15:56
comments: true
categories: 
---

<img src="/resources/thermo_original.jpg" align="left" alt="$5 Hygrometer"/>
This weekend I opened up one of the cheap-but-funky thermometers/hydrometers
from [Lets Make Time](http://www.letsmaketime.com.au)
and replaced the thermometer mechanism with the 
Aruidno-controlled Switec X25.168 stepper.  It turned out relatively easy,
modulo one wrong turn.

<img src="/resources/thermo_back.jpg" align="right" alt="back removed"/>
There are no screws or seams on the themometer housing, so it wasn't clear how to get into
it.  I used a dremel to cut away the back panel, which gave me access to the
themometer mechanism, but to my surprise the face was still firmly secured.  After a bit
of poking around I discovered that I could push the whole assembly out forward - in fact
the plastic lens is only held in by friction, and the dial and mechanism are held in by
the lens.

This turns out to be really important because after careful measurement I realized
that the motor would have to be mounted snugly against the the back of the housing to
leave enough drive shaft protruding to attach a needle.
I had just cut away the nice plastic panel that I would have been ideal to screw the motor to!  Derp.
I guess that's why I bought 4 of these.

<img src="/resources/thermo_disassembly.jpg" align="left" alt="themometer disassembly"/>
Starting again with an undamaged housing, I gently pryed out the plastic lens, removed the face and mechanism,
no cutting required. #LFMF.

<img src="/resources/thermo_mount.jpg" align="right" alt="mechanism removal"/>
The needle and the bi-metal thermometer coil come off the face easily enough, but the mounting for the coil
is a crafty two-piece deal that mounts through the centre of the dial.  It appeared to be
assembled a bit like a rivet, and couple solid blows from the back with a hammer and punch 
released it cleanly from the face.

<img src="/resources/thermo_glued.jpg" align="left" alt="hot glue"/>
I originally intended to use screws to secure the stepper to the back of the housing, but there isn't much tolerance for positional
error, which made me nervous.  Instead I repurposed part of the rivet-thing to help centre the shaft in the hole in the dial face, and hot-glued the motor to the back of the housing.  Much better solution than screws!

So far so good.  Now put the needle back on, align the internal motor zero stop with zero
on the dial and figure out calibration.  Sounds easy, but there are some
issues to consider.  The motor has a sweep of 314 degrees, but this dial only 
allows about 230 degrees of movement.  My library code resets the motor on power up
by running it first forward 315 degrees, then backward 315 degrees, hitting both of
the stops.  The far stop isn't reachable now, so I changed the library to only run the motor
backwards 315 degrees to hit the 0 stop.  I also added soft-limits to
the library to ensure that I never move past 700 steps forward.

While trying to calibrate the dial I found the needle slipping a little, aggravated 
by the vibration caused by the power-on reset.  With the needle slipping, calibration was impossible.
I tried applying the smallest drop of hot glue I could manage to the back of the needle.  That failed 
because even an almost invisible drop would catch on the dial face.  So I removed the needle, cleaned
off the glue dot and gave it a smack on the hole
with a hammer; that tightened it up nicely.  It worked so well I had to ream it out a bit with a thumb tack.
I believe the needle hole is dished a little, so you can tighten it up by flattening it out.

So here's how it looks assembled.  I haven't quite nailed calibration, but I'm going to make 
a new dial face anyway, so no need to sweat it.

<iframe width="560" height="315" src="http://www.youtube.com/embed/UJKaaRR9W6g" frameborder="0" allowfullscreen></iframe>

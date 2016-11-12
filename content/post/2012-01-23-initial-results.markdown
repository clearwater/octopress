---

title: "Initial Results"
date: "2012-01-09T14:16:00+10:00"

categories:
 - Switec X25
 - Arduino
---

Wiring It Up
------------

Given the comments by [Toby Catlin](http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1260978962)
about cooking the motors while soldering, I opted to make up a harness with a connector rather than
soldering directly to the motor.
The pins on each winding exactly match the spacing of the first and fourth pins
of a standard 0.1" connector.  JST RE connectors are the right pitch, but the pins on the motor are
too short and too narrow to engage with the connectors.  For my first harness I cut up
a floppy disk cable connector into two 4-hole sections and soldered wire to the first and fourth
pins.  It worked fine but it is pretty bulky, and the metal contacts in the connector did not solder
very easily.  For now I just pushed the tinned ends of the wires directly into the Arduino connectors.

I wrote some code for the Arduino to step the motor using the IO pattern established
in [this post](http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1260978962)
and a quick ruby script to query my pfSense firewall to get some live data to test with.

Add some duct tape for a gauge, and behold the simplest analog bandwidth meter ever:

{{< youtube  vwAxRk_5oXA >}}

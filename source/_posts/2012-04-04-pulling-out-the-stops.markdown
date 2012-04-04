---
layout: post
title: "Pulling out the Stops"
date: 2012-04-04 09:58
comments: true
categories: 
---

Or more accurately, filing off the stops.

Recently Tim Hirzel asked in the comments on this blog if I knew
of a source of motors without stops, or if the X25.168's could be
modified to remove the stops and open up a full 360 degree rotation.

Good question!  The [Buyers Guide] lists 6 models
of motors without stops, but a quick search turned up no suppliers
selling these in small volumes.

So I figured it was time to figure out if the stops can be removed.  Note that I'm working
on a VID-29 clone, not a genuine Switec X25.168 here.
There are 4 tiny screws that open the case revealing this:

![image](/resources/2012-04-04/imgp9223.jpg)

The final drive gear is the one sitting loose, and it is trivially removed.  Flipping
it over reveals the mechanism for the stop; a raised trapezoidal bump on the gear face.

![image](/resources/2012-04-04/imgp9225.jpg)

I cut off the stop with a Stanley knife, and filed it down a bit with a small file
until it felt pretty flat.

![image](/resources/2012-04-04/imgp9226.jpg)

Reassembly is easy, and lo! it works.

<iframe width="560" height="315" src="http://www.youtube.com/embed/kY2yiKImWJE" frameborder="0" allowfullscreen></iframe>
 
You can see the rotation hesitates in the video - this is because of the acceleration/decelleration
logic in the SwitexX25 library; I'm spinning 360 degrees, stopping, then spinning again.  I'll need to
add some better methods to the library to support free rotation.


---
layout: post
title: "Using the SwitecX25 Library"
date: 2012-02-16 18:04
comments: true
categories: 
---

Getting Started with the SwitecX25 Library
-------------------

For Arduino IDE version 1.0 and later you can store user-contributed libraries in a subdirectory
of your sketch directory named 'libraries'.  In fact you really should install them there
to ensure that they persist when you upgrade the IDE.

So figure out where your project directory is (under OSX this is available in the ```Arduino -> Preferences``` menu), create a subdirectory called ```libraries``` with the project directory.  The name is important, so use exactly that.  Then inside that libraries directory checkout the SwitecX25 library.  You should end up with this structure:
```
libraries
  |
  +-- SwitecX25
     |
     +-- SwitecX25.cpp
         SwitecX25.h
```

There is also an examples directory under that, but those two files are the critical parts of the library.

Restart the IDE and you should see the library in your ```Sketch -> Import Library``` menu.  It appears in a separate
section at the bottom marked ```contributed```.  Now start a new sketch.  Here's a minimum Hello World
sketch for the Switec X25 that runs the motor against the zero stop then moves the motor to the center
of its range.

```
#include <SwitecX25.h>

// standard X25.168 range 315 degrees at 1/3 degree steps
#define STEPS (315*3)

// For motors connected to pins 3,4,5,6
SwitecX25 motor1(STEPS,3,4,5,6);

void setup(void)
{
  // run the motor against the stops
  motor1.zero();
  // start moving towards the center of the range
  motor1.setPosition(STEPS/2);
}

void loop(void)
{
  // the motor only moves when you call update
  motor1.update();
}
```

I've added this little sketch to the library as an example, so it will appear as ```File -> Examples -> SwitecX25 -> center```.

---

title: "LED Gauge Backlighting"
date: "2012-02-11T17:14:00+10:00"

categories:
 - Switec X25
---
{{< img src="/resources/thermo_backlit.png" pos="right" label="LED Backlighting" >}}

Today I added an LED backlight to my square gauge.
I really like how light leaks from the grills at the top
and bottom of gauge.

<!--more-->

I decided not to use RGB LEDs in this build due to size
and pin-count constraints.
The white LED was originally part
of a solar-powered LED light string.

These are side-emitting
LEDs by virtue of a conical indent in the tip of the lens that
refracts much of the light sideways.
I tried grinding back the lens and using blobs of hot-glue to make
the lighting more diffuse, but in the end I wasn't convinced
it was an improvement, and so the simpler design won out.

{{< img src="/resources/thermo_led.png" pos="left" label="with face removed" >}}

I soldered the 330&#8486; current-limiting resistor to the LED.
I trimmed the leads on the LED and resistor really short to get it
all to fit.  I would have liked the resistor tight against
the wall to prevent a dark spot, but it didn't work out that way.

The holes for the connection wires had to be drilled
right in the extreme inner corner to avoid the stepper motor on the back.
The cathode wire goes to a PWM pin on the Arduino, and the anode
to ground.  I recently added LED control options to the Gaugette software
to control the brightness.

{{< img src="http://www.battlecruiserzone.com/Boom1.jpg" pos="right" >}}
ZOMG, now this gauge [totally looks like](http://totallylookslike.icanhascheezburger.com/) the
helmets worn by the Viper pilots in the original 80's
Battlestar Galactica series!

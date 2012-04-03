---
layout: post
title: "Reading Joystick Inputs with GPIO"
date: 2012-04-03 11:04
comments: true
categories: 
---
The Chumby Hacker Board has a 5-way (Panasonic EVQQ7)(/resources/ATR0000CE9.pdf) dpad joystick on one corner which is connected to the CPU's GPIO lines.

{%img /resources/evqq7.png %}

The following table shows the signal names and pin addresses for each of the
switch contacts A-E.  Holding the board such that the switch is in the south east
corner [as shown here](http://clearwater.github.com/chumby-oe/blog/2012/03/20/chumby-hacker-board-illustrated/), A is east, B is south, C is north, D is west and E is depressed.

 - A : east : GPMI CE0n : BANK2_PIN28
 - B : south : GPMI WPn : BANK0_PIN23
 - C : north : GPMI WRn : BANK0_PIN24
 - D : west : GPMI RDn : BANK0_PIN25
 - E : down : PWM4 : BANK_1_PIN30 (aka CHUMBY BEND)

Each of these inputs is pulled high, and goes low when the switch is closed.
Capacitors are used to prevent switch bounce.

{%img /resources/sw400.png %}

To read these inputs using GPIO you must

 - set the associated pin to GPIO mode,
 - disable output on the pin,
 - read the associated GPIO register to get the value

For example to read switch E using the GPIO library available
in the [chumby-sampler](https://github.com/clearwater/chumby-sampler) repo:

```
GPIO gpio;
gpio.open();

// E is on bank1, pin 30

// Set GPIO mode for BANK1_PIN30
// See imx23 Table 37-14
gpio.set(HW_PINCTRL_MUXSEL3_SET, 0x30000000);

// Disable output mode for BANK1_PIN30
// See imx23 Table 37-75
gpio.set(HW_PINCTRL_DOE1_CLR, 0x40000000);

// read the value into bit 0
// See imx23 Table 37-75
// Note that the input is active-low but we invert it below so that
// value_E will be 0 if the switch is open, 1 if the switch is closed.
unsigned int value_E = (gpio.get(HW_PINCTRL_DIN1, 0x40000000) >> 30) ^ 0x1;

```

A complete example reading the state of all 5 switches 
is available [here](https://github.com/clearwater/chumby-sampler/tree/master/dpad).


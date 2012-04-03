---
layout: post
title: "Reading Joystick Inputs with GPIO"
date: 2012-04-03 11:04
comments: true
categories: 
---
The Chumby Hacker Board has a 5-way Panasonic EVQQ7([Datasheet](/resources/ATR0000CE9.pdf)) dpad joystick on one corner at SW400.  This post explains how to read the state of this switch via the GPIO interface.

{%img /resources/evqq7.png %}

Holding the CHB such that the switch is in the south east
corner [as pictured here](http://clearwater.github.com/chumby-oe/blog/2012/03/20/chumby-hacker-board-illustrated/), switch A closes when the stick is pushed east, B is south, C is north, D is west and E closes when the stick is depressed.  Sad dpad is sad.

The following table lists the signals and pin addresses for each of the
switch contacts A-E.  

 - A : east : GPMI CE0n : BANK2_PIN28
 - B : south : GPMI WPn : BANK0_PIN23
 - C : north : GPMI WRn : BANK0_PIN24
 - D : west : GPMI RDn : BANK0_PIN25
 - E : down : PWM4 : BANK_1_PIN30 (aka CHUMBY BEND)

Each of these inputs is pulled high, and driven low when the switch is closed.
1nF capacitors on each signal line prevent switch bounce.

{%img /resources/sw400.png %}

To read these inputs using GPIO you must make 3 calls:

 - set the associated pin to GPIO mode,
 - disable output on the pin,
 - read the associated GPIO register to get the value

For example to read switch E using the GPIO library from the
[Chumby Sampler](https://github.com/clearwater/chumby-sampler) code:

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

Complete sample code for reading the state of all 5 switches 
is available in the [Chumby Sampler](https://github.com/clearwater/chumby-sampler/).


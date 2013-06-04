---
layout: post
title: "Improved Test Code for Rotary Encoders"
date: 2013-06-04T16:52:28+10:00
comments: true
external-url: 
categories: 
---

{% img right /resources/2013-06-04/raspberry-pi-rotary-encoder.png %}
While working through a few queries about the [rotary encoder library](/gaugette/2013/01/14/rotary-encoder-library-for-the-raspberry-pi/),
it became evident that it would help to have a better test application to diagnose wiring issues.

I've [committed](https://github.com/guyc/py-gaugette/blob/19bf43f29fcc02d8865a7a2078447b2772a2af85/samples/rotary_test.py)
a better version of ```rotary_test.py``` that writes out a
comprehensive table of state information, updated whenever anything changes.

<br clear="both"/>

The output looks like this:

```
A B STATE SEQ DELTA SWITCH
1 1   3    2    1    0
0 1   2    3    1    0
0 0   0    0    1    0
1 0   1    1    1    0
1 1   3    2    1    0
0 1   2    3    1    0
```

The values in the table are defined as follows:

| Column | Meaning                  |
|--------|--------------------------|
|   A    | Raw value of input A     |
|   B    | Raw value of input B     |
| STATE  | Quadrature state 0,1,3,2 |
|  SEQ   | Ordinal sequence 0,1,2,3 |
| DELTA  | Net change in position   |
| SWITCH | Push-button switch state |

One small note on the implementation: although there are library calls to directly 
fetch each of the values in the table, the test program only calls the library to
retrieve ``STATE`` and ``SWITCH``, and then derives the other values from ``STATE``.  I did this to
make sure each column is generated from the same inputs.  If instead I made separate library calls
to fetch each column value, it is quite likely that the inputs would change while generating a row of this table, 
producing inconsistent and confusing results.

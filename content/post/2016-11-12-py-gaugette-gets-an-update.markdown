---
title: "Version 3 of py-gaugette"
date: "2016-11-12T14:39:00+10:00"
draft: True
categories:
 - "Switec X25"
 - "Arduino"
---

I've made some major changes to the py-gaugette library to address
several issues that have accumulated over time, namely:

 - use interrupts for rotary encoder
 - fully Python 3 compatible
 - works with current version of Py-WiringPi
 - uses dependency injection for GPIO and SPI interfaces
 - updated Google Sheets to use new API

## Dependency Injection for GPIO and SPI

Classes that interact with the GPIO or SPI interfaces now take
an instance of that interface as a parameter to the constructor.
This avoids the issue of having multiple classes trying to initialise
the GPIO library, and makes it easy to pass alternative interface
implementations.

## Interrupts for Rotary Encoders

The original implementation of the rotary encoder library used polling.
On the Raspberry Pi it now supports interrupts, although the polling
behaviour is still supported.

## Fully Python3 Compatible

While the library has been mostly Python 3 compatible, there were a few
exceptions.  In particular the SSD1306 class depended heavily on the Python 2
behaviour of the division operator, which changed in Python 3.  I've rewritten
the calculations to mostly use bit shifts rather than division.


{{<code>}}
sudo apt-get install python-pip python-dev
sudo pip install wiringpi
{{</code>}}cd

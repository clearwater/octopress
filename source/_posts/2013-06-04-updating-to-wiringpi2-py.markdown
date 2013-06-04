---
layout: post
title: "Updating &nbsp;py-gaugette to &nbsp;wiringpi2"
date: 2013-06-04T16:14:51+10:00
comments: true
external-url: 
categories: 
---

{% img https://projects.drogon.net/wp-content/uploads/2013/05/adaLcd-1024x602.jpg %}
Phillip Howard and Gordon Henderson recently [announced](http://pi.gadgetoid.com/post/039-wiringpi-version-2-with-extra-python)
the availability of [WiringPi2](http://wiringpi.com/) along with a new python wrapper
[WiringPi2-Python](https://github.com/Gadgetoid/WiringPi2-Python).

The python library name has changed from ```wiringpi``` to ```wiringpi2```, so any application
code referencing the module needs to be updated.
I've forked [py-gaugette](https://github.com/guyc/py-gaugette) to create
a [wiringpi2 branch](https://github.com/guyc/py-gaugette/tree/wiringpi2).  I plan to roll
this into the master branch in the not-too-distant future.  When I do, wiringpi2 will
be a requirement for using py-gaugette.

Here's how I installed the wiringpi2 libraries on my boxes:

### Install WiringPi2

First install wiringPi.  At the time of writing, it does _not_ work to install
with `sudo pip install wiringpi2`; the library builds and installs fine, but
the version installed is not compatible with current version of `WiringPi2-Python`.

```
git clone git://git.drogon.net/wiringPi
cd wiringPi
./build
cd ..
```

### Install WiringPi2-Python

```
git clone https://github.com/Gadgetoid/WiringPi2-Python.git
cd WiringPi2-Python/
sudo python setup.py install
cd ..
```

### Checkout py-gaugette for WiringPi2

```
git clone git://github.com/guyc/py-gaugette.git
cd py-gaugette
git checkout wiringpi2
cd ..
```




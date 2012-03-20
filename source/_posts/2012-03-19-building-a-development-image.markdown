---
layout: post
title: "Building a Development Image"
date: 2012-03-19 14:46
comments: true
categories: 
---

The standard "chumby-starter-image" we've been building with the OE toolchain doesn't include a development environment for compiling and linking on the device itself.  In response to [this question](http://forum.chumby.com/viewtopic.php?pid=41604) in the forums I've added a new recipe file "chumby-dev-image" which bakes in the compiler and linker and friends by incorporating the OE task-native-sdk package.  This in turn pulls in these packages:

 - gcc-symlinks 
 - g++-symlinks 
 - cpp  
 - cpp-symlinks
 - binutils-symlinks 
 - make 
 - virtual-libc-dev
 - task-proper-tools
 - perl-modules
 - flex
 - flex-dev
 - bison
 - gawk
 - sed
 - grep
 - autoconf
 - automake
 - make
 - patch
 - patchutils
 - diffstat
 - diffutils
 - libstdc++-dev 
 - libtool
 - libtool-dev 
 - libltdl-dev 
 - pkgconfig

I have a feeling most people will probably prefer this image over the old chumby-starter-image, so I've made chumby-dev-image the default make target.  You can change the default target by modifying this line in the Makefile: ```export CHUMBY_IMAGE:=chumby-dev-image```.

And Another Thing
-----------------

It turns out that we also need to add libgcc-dev to the list of packages.  Without it ```libgcc_s.so``` will not be created and you will see errors like this when you compile:
```
/usr/lib/gcc/arm-angstrom-linux-gnueabi/4.5.3/../../../../arm-angstrom-linux-gnueabi/bin/ld: cannot find -lgcc_s
collect2: ld returned 1 exit status
```
By adding the libgcc-dev package, we get ```/usr/lib/libgcc_s.so```, which interestingly is an ld script file with the following contents:
```
/* GNU ld script
   Use the shared library, but some functions are only in
   the static library.  */
GROUP ( libgcc_s.so.1 libgcc.a )
```

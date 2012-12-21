---
layout: post
title: "Better Fonts for the SSD1306"
date: 2012-11-11 16:42
comments: true
categories: 
---

{% img right /resources/2012-11-08/ssd1306.jpg %}
The first release of the SSD1306 support library [py-gaugette](https://github.com/guyc/py-gaugette)
used the 5x7 pixel fonts from the 
[Adafruit GFX library](https://github.com/adafruit/Adafruit-GFX-Library/blob/master/glcdfont.c).
That's a fine and compact font, but wouldn't it be nice to have some pretty high-res fonts
to take advantage of the memory and resolution we have to work with?

Generating Font Bitmaps
-----------------------

{% img right /resources/2012-11-11/tahoma_16.jpg %}
I started with [The Dot Factory](http://www.pavius.net/2009/07/the-dot-factory-an-lcd-font-and-image-generator/) by Eran Duchan.  Its a handy C# (Windows) tool for generating C and C++ bitmap files quickly, and [source code is available](https://github.com/pavius/The-Dot-Factory).  I modified it to generate Python code, and to add a kerning table to store the minimum number of pixels the cursor must move between any two characters to avoid collison.  

The kerning isn't completely right yet  - I noticed that the underscore character can slip beheath other characters.  I'll need to look at that some more in due time - and I'd also like to replace the C# app for a command-line tool to generate the rasterized image files.

Each font is stored in a module like the following.  The size suffix (16 in this case) indicates the character height in pixels.
The descriptor table specifies the width of each character and the character's offset in the bitmap.

```
# Module gaugette.fonts.arial_16
# generated from Arial 12pt                                                                                                         

name        = "Arial 16"
start_char  = '#'
end_char    = '~'
char_height = 16
space_width = 8
gap_width   = 2

bitmaps = (
    # @0 '!' (1 pixels wide)
    0x00, #  
    0x80, # O
    0x80, # O
    0x80, # O
    0x80, # O
    0x80, # O
    0x80, # O
    0x80, # O
    0x80, # O
    0x80, # O
    0x80, # O
    0x00, #  
    0x80, # O
    0x00, #  
    0x00, #  
    0x00, #  

    # @16 '"' (4 pixels wide)
    0x00, #     
    0x90, # O  O
    0x90, # O  O
    0x90, # O  O
    0x90, # O  O
    0x00, #     
    0x00, #     
    0x00, #     
    0x00, #     
    0x00, #     
    0x00, #     
    0x00, #     
    0x00, #     
    0x00, #     
    0x00, #     
    0x00, #     

    # @32 '#' (9 pixels wide)
    0x00, 0x00, #          
    0x11, 0x00, #    O   O 
    0x11, 0x00, #    O   O 
    0x11, 0x00, #    O   O 
    0x22, 0x00, #   O   O  
    0xFF, 0x80, # OOOOOOOOO
    0x22, 0x00, #   O   O  
    0x22, 0x00, #   O   O  
    0x22, 0x00, #   O   O  
    0xFF, 0x80, # OOOOOOOOO
    0x44, 0x00, #  O   O   
    0x44, 0x00, #  O   O   
    0x44, 0x00, #  O   O   
    0x00, 0x00, #          
    0x00, 0x00, #          
    0x00, 0x00, #          
...
)

# (width, byte offset)
descriptors = (
    (1,0),# !
    (4,16),# "
    (9,32),# #
...
)

# kerning[c1][c2] yeilds minimum number of pixels to advance
# after drawing #c1 before drawing #c2 so that the characters
# do not collide.
kerning = (
    (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,),
...
)
```

Note the font is a module, not a class, because it allows a very concise syntax:

```
from gaugette.fonts import arial_16
textSize = led.draw_text3(0,0,"Hello World",arial_16)
```

{% img right /resources/2012-11-11/old_english_text.jpg %}

Supporting Horizontal Scrolling
-------------------------------

In the process of testing these fonts, I realized I would like to be able to scroll horizontally,
and the SSD1306 doesn't have hardware support for that.  Vertical scrolling is accomplished using
the ```SET_START_LINE``` command, but the horizontal scrolling commands do not support scrolling
through an image that is wider than the display.  We need to do it in software.

It turns out that blitting memory from the Pi to the SSD1306 over SPI is pretty fast; fast enough
to get a reasonable horizontal scroll effect by blitting complete frames from the Pi's
memory to the SSD1306.  There's just one thing - the default memory mode of the
SSD1306 is [row-major](http://en.wikipedia.org/wiki/Row-major_order), and 
for horizontal scrolling we really want to send a __vertical slice__ of the memory buffer
over SPI.  To avoid buffer manipulation I switched the Pi-side memory buffer to use
[column-major order](http://en.wikipedia.org/wiki/Column-major_order#Column-major_order),
and use ```MEMORY_MODE_VERT``` on the SSD1306 when blitting.

To illustrate: the memory buffer is stored as a python list of bytes.  Consider a virtual
buffer that is 256 columns wide and 64 rows high.  Using column-major layout
we can address the 128 columns starting at column 100 using the python
list addressing ```buffer[100*64/8:128*64/8]```.

```
buffer = [0] * 256 * 64 / 8                              # buffer for 256 columns, 64 rows, 8 pixels stored per byte
start = 100 * 64 / 8                                     # byte offset to 100th column
length = 128 * 64 / 8                                    # byte count of 128 columns x 64 rows
led.command(led.SET_MEMORY_MODE, led.MEMORY_MODE_VERT)   # use vertical addressing mode
led.data(buffer[start:start+length])                     # send a vertical slice of the virtual buffer
```

Note that using column-major layout we cannot easily blit a __horizontal__
slice of the virtual memory buffer into display ram, so we can't use the same method for
vertical scrolling.  Stick with ```SET_START_LINE``` for vertical scrolling.  The combination
of these methods gives us fast horizontal and vertical scrolling.

{% youtube fSCDr8A_ItU %}

An updated [library](https://github.com/guyc/py-gaugette) with [sample code](https://github.com/guyc/py-gaugette/blob/master/samples/font_test.py) is available on github.

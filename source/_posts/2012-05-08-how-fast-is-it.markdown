---
layout: post
title: "How Fast Is It?"
date: 2012-05-08 09:06
comments: true
categories: 
---

I recently [removed the internal stops](/blog/2012/04/04/pulling-out-the-stops/) on a VID-29 stepper.  I've used this free-turning motor and an optical sensor to exerimentally determine the operational limits of the motor.  The test rig uses a photo-interruptor (salvaged from a pre-PC era 8-inch floppy drive).

{% img right /resources/2012-05-08/accel-test.jpg %}

Methodology
-----------

The test strategy is to move the need forward under varying conditions, then move the needle back to the home position in a known-reliable manner while counting the steps to get back to the start position.  If the steps counted back do not match the number of steps programmed forward then we know we have exceeded the operational limits of the motor.

After some experimentation I selected a delay of 1000&mu;S per step for the counting phase as this is well within the safe limits of operation.  This gives perfectly repeatable results, confirming that the sensor is accurate enough to detect a single one-third degree step.

Be sure your needle is tight!  Until I eliminated needle slippage, my results were very unreliable, with anomalous drifts both above and below the expected results.

Constant Speed Test 
-------------------

Move the needle forward at constant speed with varying speeds to determine the operational limits of step-frequency.

One thing to note here is that we are reading the sensor analog input inside our timing loop, which means the step periods shown are slightly below the actual value.

The following table shows the results from the constant speed test.
Each test was repeated 5 times.  In each case the expected result was
500.  

Delay &mu;S | Test 1 | Test 2 | Test 3 | Test 4 | Test 5 | Hz | &deg;/S
----- | ------ | ------ | ------ | ------ | ------ | ----- | -----|
500 | 8 | 2 | 2 | 2 | 2 | 2000 | 667
520 | 2 | 2 | 3 | 2 | 2 | 1923 | 641
540 | 2 | 2 | 2 | 2 | 2 | 1852 | 617
560 | 2 | 3 | 0 | 8 | 8 | 1786 | 595
580 | 2 | 8 | 4 | 500 | 500 | 1724 | 575
600 | 518 | 500 | 500 | 506 | 500 | 1667 | 556
620 | 500 | 500 | 500 | 500 | 500 | 1613 | 538
640 | 500 | 500 | 500 | 500 | 500 | 1563 | 521
660 | 500 | 500 | 500 | 500 | 500 | 1515 | 505
680 | 500 | 500 | 500 | 500 | 500 | 1471 | 490
700 | 500 | 500 | 500 | 500 | 500 | 1429 | 476

The results show that with a step period below 580&mu;S the motor did not advance with each step.  Above 600&mu;S it was reliably moving 500 steps forward. Interestingly in the boundary range of 580&mu;S and 600&mu;S the motor sometimes advanced _more_ than the expected number of steps.  This is an indication that the momentum of the needle is turning the motor after the motor stops driving forward - overshoot.

Observations
------------

I compared my results with the VID29 data sheet which states rather confusingly that "The angular speed can reach more than 500Hz" (presumably they mean &deg;/S, not Hz), and elsewhere that the maximum driving frequency is 600Hz (that just seems wrong). Bear in mind that our timings do not account for the overhead of code execution time.  Our results suggest that, with this particular needle, the motor can be reliably driven at 1613Hz with an angular velocity of 538&deg;/S with no missed steps and no overshoot.  Very slightly higher speeds could be obtained if the needle is decellerated before stopping to avoid overshoot.

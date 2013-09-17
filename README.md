youtube-chromeless-scaling-thumnbail
====================================

Main.as is an adaptation of YouTube's demo code modified slightly to illustrate an issue
with the presentation of the thumbnail "frame" at sizes smaller than the default.

It appears that calls to player.setSize(w,h) are no longer working on the thumbnail.  Once the video 
is clicked and  begins playing resizing works, but at present the initial thumbnail state is broken
without resize capability.

You can build this example with Flex SDK:

mxmlc  Main.as

Then open the resulting SWF in a browser.

The player loads the video by calling cueVideoById(), notice the video in the initial thumbnail state.

The resize handler will fire immediately to resize the player and whenever you change the browser window size.

As you resize the player window, notice that:

* The thumbnail image is cut off, rather than scaling to fit as was the previous behavior
* The Play button is not properly centered or is completely hidden from view depending on size of the player.  It used to remain properly centered.

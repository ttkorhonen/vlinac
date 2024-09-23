# vlinac
APS Virtual Linac for EPICS 7

  Virtual LINAC Demo
  ==================
  Created by Ned Arnold
  Updated for EPICS 7 by Timo Korhonen (2024)

The Virtual LINAC Demo is an EPICS IOC application that simulates
an electron beam progressing down a LINAC. Several steering coils,
BPMs, and other typical accelerator components are simulated. See
documentation/Virtual_Linac_Info.pdf for a complete explanation.

To start the Virtual Linac IOC, run the 'startIoc.sh' script found
in the top of the vlinac application  (on the Mac this is called
'startIoc.command' and can just be double-clicked in the Finder).
Other start scripts are also provided to run the channel access
client tools included with the application.

The file documentation/Virtual_Linac_Info.pdf provides a description
of how to use the Virtual Linac application once the IOC and its
MEDM screens are running.

This demonstration is provided already built for several platforms on
which it has been tested: Linux on x86 and x86_64, and Mac OS-X on M1 and x86.  
It should be possible to build it from source for other supported platforms as needed.

On Mac OS-X you will need to have the readline5 library installed,
which is available using fink.  To get it install fink if you don't
already have it, then run 'fink install readline5' in a terminal
window.

For Windows systems the client tools including MEDM are not provided
with the program itself, and should be installed using the EPICS Win32
Extensions Installer.  There is a separate README.Win32.txt file in
this directory which windows users should look at.

## Making Changes

You may modify the two db/*.db or st.cmd files as you wish, adding
new records or changing the startup commands.  However if you wish
to make changes to the State Notation Lanuage or C code you will
have to recompile the application, which needs copies of both EPICS
Base and the State Notation Compiler/Sequencer to have been
installed and built.

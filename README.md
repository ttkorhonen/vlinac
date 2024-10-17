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

To start the IOC

If you have an EPICS Base 7.0.x built somewhere, you can just do
 
$softIocPVA -m user=<what you prefer> -d vlinacApp/Db/xxVirtualLinac.db
 
This should get the IOC going.
The sequencers are not needed; the OACTree scripts will do the job.
 
With CS-Studio Phoebus, open css/VirtualLinac_test.bob (or Virtual_Linac.bob)
 
That should open the OPI, however **you need to define the macro “user”** to match the PV names.
 
The sequences are in the OACTree directory:
LoopVLAutoControl3.xml (sorry for the hackerish name…) will run the automatic startup.
LoopVLAutoControlPVA.xml  does the same, but with pvAccess.
orbitPlot will update the orbit display; it replaces the beamTrajectory seq. 
This is not absolutely necessary, but it is nice to see the orbit updating.
 
The PV names need probably to be changed (unless you ran the IOC with “user=timokorhonen”.

If you run on Linux, the plugin names have to have the extension “.so”.  I was running these on MacOS, so the extension is “.dylib”.
 
 
If you prefer, you can also build the IOC. Sequence programs are there if one wants to check how they work, and compare with OACTree.


To start the Virtual Linac IOC, run the 'startIoc.sh' script found
in the top of the vlinac application  (on the Mac this is called
'startIoc.command' and can just be double-clicked in the Finder).
Other start scripts are also provided to run the channel access
client tools included with the application.

The file documentation/Virtual_Linac_Info.pdf provides a description
of how to use the Virtual Linac application once the IOC and its
MEDM screens are running.



This has not yet been tested on Windows.

## Making Changes

You may modify the two db/*.db or st.cmd files as you wish, adding
new records or changing the startup commands.  However if you wish
to make changes to the State Notation Lanuage or C code you will
have to recompile the application, which needs copies of both EPICS
Base and the State Notation Compiler/Sequencer to have been
installed and built.

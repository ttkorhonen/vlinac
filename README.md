# vlinac
APS Virtual Linac for EPICS 7. This repository was created to demostrate basic use of the oac-tree sequencer with EPICS.

  Virtual LINAC Demo
  ==================
  Created by Ned Arnold
  Updated for EPICS 7 by Timo Korhonen (2024)

The Virtual LINAC Demo is an EPICS IOC application that simulates
an electron beam progressing down a LINAC. Several steering coils,
BPMs, and other typical accelerator components are simulated. See
documentation/Virtual_Linac_Info.pdf for a complete explanation.

## Preparing the IOC

If you have an EPICS Base 7.0.x built somewhere, you can just do
 
`$softIocPVA -m user=<what you prefer> -d vlinacApp/Db/xxVirtualLinac.db`
 
to get the IOC going.
The sequencers are not needed; the OACTree scripts will do the job.

If you prefer, you can also build the IOC. Edit `configure/RELEASE.local` to match your setup
and use the regular EPICS build methods (i.e., type `make`.)

Sequence programs (SNL) are there if one wants to check how they work, and compare with OACTree.
But here we want to run the OACTree scripts, so compiling them is not necessary.

## Opening the user interfaces

With CS-Studio Phoebus, open `css/Virtual_Linac.bob`.
 
That should open the OPI, however **you may need to define the macro “user”** to match the PV names.
 
## OACTree sequences

The sequences are in the OACTree directory. There are two options to prepare them for running:

### Using template substitution

If you can use msi (from the EPICS base), you can adapt to your environment by
processing the `.template` files, like this:

on Linux:

`msi -M user=$USER -o <output file name> VLAutoControlCA.template `

on MacOS:

`msi -M user=$USER,libext=dylib  -o <output file name> VLAutoControlCA.template`

The libext macro changes the library file extension. It is set to `so` by default,
as it is expected that these are mostly run on Linux.

Similarly, for PVA

`msi -M user=$USER, VLAutoControlPVA.template -o <output file name>` (Linux)

### Editing the xml files

If you do not have, or do not want to use msi, you need to edit either

`VLAutoControlCA.xml`, or `VLAutoControlPVA.xml` to match your setup and PV names.

Obviously, the first one uses Channel Access and the second one pvAccess.

The PV names need probably to be changed (unless you ran the IOC with “user=test”.
If you run on Linux, the plugin names have to have the extension “.so”.  
Running these on MacOS, the extension should be changed to “.dylib”.

### Beam orbit display

There is another script, **orbitPlot.xml** that will update the orbit display.
It replaces the beamTrajectory sequencer program in the original vlinac.
This is not absolutely necessary, but it is nice to see the orbit updating.

It has both a `.template` and `.xml` versions and needs to be handled similarly to the other sequence files.

## Running the demo

You can either run the demo with `softIocPVA` as explained above, or if you decided to build, then as follows:

To start the Virtual Linac IOC, run the 'startIoc.sh' script found
in the top of the vlinac application  (on the Mac this is called
'startIoc.command' and can just be double-clicked in the Finder).
Other start scripts are also provided to run the channel access
client tools included with the application.

Run the OACTree scripts with;

`sequencer-cli -f <your sequence>`

If you want to skip creating (temporary) xml files, at least on Linux and MacOS 
the following should work:

`msi -M user=$USER,libext=dylib orbitPlot.template | sequencer-cli -f /dev/stdin` (Mac)
`msi -M user=$USER orbitPlot.template | sequencer-cli -f /dev/stdin` (Linux)

The file documentation/Virtual_Linac_Info.pdf provides a description
of how to use the Virtual Linac application once the IOC is running.

However, in short:

When the OACTree sequencer(s) are running, you should see a message "Sequencer ready" in the
text box on the OPI. Then, pressing "Auto-Start" in the upper right corner starts running the setup.
It goes through the actions, and finally the beam reaches the target, and the message 
"Sequence is complete" will be displayed in the text box. Switching to "Manual Control" re-arms the sequence,
and the "Reset" button restores the initial state of the linac.

In manual mode, you can try yourself to thread beam through the linac. Even if this is a simplified demo,
it is surprisingly complex to find out a good sequence of actions.

```{note} Running on Windows
This has not yet been tested on Windows. 
I have no means to test building on Windows, but the `softIOC` method should work.
```

## Making Changes

You may modify the *.db or st.cmd files as you wish, adding
new records or changing the startup commands.  However if you wish
to make changes to the State Notation Lanuage or C code you will
have to recompile the application, which needs copies of both EPICS
Base and the State Notation Compiler/Sequencer to have been
installed and built.

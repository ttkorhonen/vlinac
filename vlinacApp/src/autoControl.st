program autoControl

option -c;	/* don't wait for all channels to connect */
option +r;	/* reentrant */

short   mode;
assign  mode to "{user}:autoC";
monitor mode;

short   htrMon;
assign  htrMon to "{user}:cathodeTempM";
monitor htrMon;

string  msg;
assign  msg to "{user}:OP:autoMsg";

float   htr;
assign  htr to "{user}A:cathodeCurrentC";

short   beamOn;
assign  beamOn to "{user}:gunOnC";

short   gv1;
assign  gv1 to "{user}:GV1:positionC";

short   psMode;
assign  psMode to "{user}:psNormalModeC";

float   h1A;
assign  h1A to "{user}A:H1:setCurrentC";

float   v1A;
assign  v1A to "{user}A:V1:setCurrentC";

float   h2A;
assign  h2A to "{user}A:H2:setCurrentC";

float   v2A;
assign  v2A to "{user}A:V2:setCurrentC";

float   h3A;
assign  h3A to "{user}A:H3:setCurrentC";

float   v3A;
assign  v3A to "{user}A:V3:setCurrentC";

float   h4A;
assign  h4A to "{user}A:H4:setCurrentC";

float   v4A;
assign  v4A to "{user}A:V4:setCurrentC";

float   h5A;
assign  h5A to "{user}A:H5:setCurrentC";

float   v5A;
assign  v5A to "{user}A:V5:setCurrentC";


%%#include <epicsThread.h>

ss autoCtlSS
{
state init
  {
        when()
            {
            /* Set PV that disconnects ramping PVs from PS PVs  */
            /* uses Simulation Mode of AO record */
            psMode = 1;
            pvPut(psMode);
%%          epicsThreadSleep(.2);

            /* Set ramping PVs to 0 */
            h1A = 0;
            v1A = 0;
            h2A = 0;
            v2A = 0;
            h3A = 0;
            v3A = 0;
            h4A = 0;
            v4A = 0;
            h5A = 0;
            v5A = 0;
            pvPut(h1A);
            pvPut(v1A);
            pvPut(h2A);
            pvPut(v2A);
            pvPut(h3A);
            pvPut(v3A);
            pvPut(h4A);
            pvPut(v4A);
            pvPut(h5A);
            pvPut(v5A);

            mode = 0;
            pvPut(mode);
%%          epicsThreadSleep(.1);
            } state waitForAuto
  } 


state waitForAuto
  {
	when(mode)
	    {
            beamOn = 0;
            pvPut(beamOn);
            gv1 = 0;
            pvPut(gv1);
%%          epicsThreadSleep(.2);

            sprintf(msg,"Setting Cathode Temperature");
            pvPut(msg);
            htr = 12.3;
            pvPut(htr);

            /* Set PV that connects ramping PVs to PS PVs  */
            /* uses Simulation Mode of AO record */
            psMode = 0;
            pvPut(psMode);
%%          epicsThreadSleep(3);
            } state waitForHtr
  }

state waitForHtr
  {
        when(!mode)
            {
            } state init

        when(htrMon > 152)
            {
            sprintf(msg,"Turning Beam On");
            pvPut(msg);
%%          epicsThreadSleep(2);
            beamOn = 1;
            pvPut(beamOn);

%%          epicsThreadSleep(3);

            /* Set ramping PVs */
            h1A = -1.31;
            v1A = 1.79;
            h2A = 2.67;
            v2A = -1.39;
            h3A = -1.68;
            v3A = -.8;
            h4A = 1.63;
            v4A = .1;
            h5A = -1.83;
            v5A = 2.21;
            sprintf(msg,"Setting H1/V1 Steering");
            pvPut(msg);
            pvPut(h1A);
            pvPut(v1A);
%%          epicsThreadSleep(3);
            sprintf(msg,"Setting H2/V2 Steering");
            pvPut(msg);
            pvPut(h2A);
            pvPut(v2A);
%%          epicsThreadSleep(3);
            sprintf(msg,"Opening Gate Valve");
            pvPut(msg);
%%          epicsThreadSleep(2);
            gv1 = 1;
            pvPut(gv1);
%%          epicsThreadSleep(3);
            sprintf(msg,"Setting H3/V3 Steering");
            pvPut(msg);
            pvPut(h3A);
            pvPut(v3A);
%%          epicsThreadSleep(3);
            sprintf(msg,"Setting H4/V4 Steering");
            pvPut(msg);
            pvPut(h4A);
            pvPut(v4A);
%%          epicsThreadSleep(3);
            sprintf(msg,"Setting H5/V5 Steering");
            pvPut(msg);
            pvPut(h5A);
            pvPut(v5A);
%%          epicsThreadSleep(3);
            sprintf(msg,"Auto-Start Complete");
            pvPut(msg);
%%          epicsThreadSleep(3);
	    } state init
  }

}


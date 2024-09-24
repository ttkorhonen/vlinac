program stabilizer

short   enableButton;
assign  enableButton to "{user}:OP:stabilizerC";
monitor enableButton;

float   cathodeTemp;
assign  cathodeTemp to "{user}:cathodeTempM";
monitor cathodeTemp;

float   cathodeCurrent;
assign  cathodeCurrent to "{user}:cathodeCurrentC";

ss stabilizerSS1 
{
  state init
    {
        when(1)
            {
            } state waitForEnable
    } 


  state waitForEnable
    {
	when(enableButton)
	    {
	      printf("Starting Stabilizer\n");
	    } state stabilize
    }

  state stabilize
    {
        when(!enableButton)
            {
	      printf("Stopping Stabilizer\n");
            } state waitForEnable

        when(delay(.5))
            {
	      printf("Stabilizing\n");
            } state stabilize
    } 
}

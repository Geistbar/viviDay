script "viviYellowRay.ash"

/*******************************************************
*					viviYellowRay()
*	Uses a yellow ray at the Inner Wolf Gym.
/*******************************************************/

void yellowRay()
{
	// Don't execute if you can't Yellow Ray
	if (have_effect($effect[Everything Looks Yellow]) > 0)
		return;
	// Fail-safe check
	cli_execute("autoattack Farming");
	// Check to see if you reached the end of the gym
	if (contains_text(visit_url("questlog.php?which=1"),"Time Left: 3")) 
	{
		visit_url("inv_use.php?pwd&whichitem=7061");
		visit_url("choice.php?pwd&option=2&whichchoice=829");
	}
	adventure(1,$location[The Inner Wolf Gym]);
}

void main()
{
	yellowRay();
}
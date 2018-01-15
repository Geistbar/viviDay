script "viviJelly.ash"

/*******************************************************
*					viviJelly()
*	Gets n elemental jellies from the Space Jellyfish
*	using the elemental charters as reliable ways to
*	access each target element.
/*******************************************************/

void getJelly(string ele, int target)
{
	location zone;
	int jellyStart = get_property("_spaceJellyfishDrops").to_int();
	if (ele == "cold")
		zone = $location[VYKEA];
	if (ele == "stench")
		zone = $location[Barf Mountain];
	if (ele == "hot")
		zone = $location[LavaCo&trade; Lamp Factory];
	if (ele == "spooky")
		zone = $location[The Deep Dark Jungle];
	if (ele == "sleaze")
		zone = $location[Sloppy Seconds Diner];
	while (get_property("_spaceJellyfishDrops").to_int() < (jellyStart + target))
		adventure(1,zone);
}

void main()
{
	// Setup
	cli_execute("outfit freedrops");
	cli_execute("autoattack Farming");
	use_familiar($familiar[Space Jellyfish]);
	
	// Actual work; valid inputs are "cold" "hot" "spooky" "stench" "sleaze"
	getJelly("stench",1);
}
script "viviWitchess.ash"

/*******************************************************
*					viviWitchess()
*	Fights chess pieces at the new witchness set.
*
*	Pawn: piece 1935
*	Knight: 1936
*	Bishop: 1942
*	Rook: 1938
*	Ox: 1937
*	King: 1940
*	Witch: 1941
*	Queen: 1939
/*******************************************************/

void chessFight(familiar f)
{
	// Fail-safe setup
	cli_execute("autoattack Farming");
	cli_execute("outfit FreeDrops");
		
	use_familiar(f);
	
	int n = 0;
	while (n < 5)
	{
		visit_url("campground.php?action=witchess");
		run_choice(1);
		visit_url("choice.php?option=1&pwd=" + my_hash() + "&whichchoice=1182&piece=" + 1936, false);
		run_combat(); // Safety check
		n+=1;
	}
	// After fight re-setting
	cli_execute("autoattack Farming");
}

void main()
{
	familiar fam = $familiar[Ms. Puck Man];
	chessFight(fam);
}
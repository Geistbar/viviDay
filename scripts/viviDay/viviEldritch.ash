script "viviEldritch.ash"

/*******************************************************
*					viviEldritch()
*	Summons Eldritch Horror for a free combat.
/*******************************************************/

void eldritchFight(familiar fam)
{
	cli_execute("Outfit FreeDrops");
	cli_execute("autoattack Farming");
	use_familiar(fam);
	
	use_skill(1,$skill[Evoke Eldritch Horror]);
	run_combat();
}

void main()
{
	eldritchFight($familiar[Stocking Mimic]);
}
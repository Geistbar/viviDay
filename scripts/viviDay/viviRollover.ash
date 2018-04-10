script "viviRollover.ash"

/*******************************************************
*					viviRollover()
*	Finishes character day and gets ready for rollover.
/*******************************************************/

void rolloverPrep()
{
	// Item Maintence
	put_shop(0,0,$item[Five Second Energy&trade;]);
	put_shop(0,0,$item[Jerks' Health&trade; Magazine]);
	put_closet(item_amount($item[black snowcone]),$item[black snowcone]);
	put_closet(item_amount($item[fish juice box]),$item[fish juice box]);
	put_closet(item_amount($item[rubber nubbin]),$item[rubber nubbin]);
	use(item_amount($item[bag of park garbage])-5,$item[bag of park garbage]);
	cli_execute("useMeatItems.ash");
	//cli_execute("PvPItemCheck.ash");
	
	// Get ready for rollover
	while (get_property("timesRested").to_int() < total_free_rests())
		cli_execute("rest");
	cli_execute("swim sprints");
	cli_execute("use Oscus's neverending soda");
	cli_execute("cast * resolutions");
	
	// Change gear and familiar
	cli_execute("outfit Rollover");
	use_familiar($familiar[Trick-or-Treating Tot]);

	//	Drink nightcap
	use_skill(1,$skill[The Ode to Booze]);
	use_familiar($familiar[Stooper]);
	drink(1,$item[Splendid Martini]);
	take_stash(1,$item[tiny plastic sword]);
	cli_execute("mix cherry bomb");
	drink(1,$item[cherry bomb]);
	put_stash(1,$item[tiny plastic sword]);
	cli_execute("shrug ode");
	
	cli_execute("hottub");
	
	// Grab photocopy
	if (item_amount($item[photocopied monster]) == 0)
		cli_execute("faxbot embezzler");
}

void main()
{
	rolloverPrep();
}
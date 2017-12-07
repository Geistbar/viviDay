script "viviDiner.ash"

/*******************************************************
*					viviDiner()
*	
/*******************************************************/

/*******************************************************
*					getUse()
*	Retrives & uses a specified quantity of a item.
/*******************************************************/
void getUse(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	
	if (qtyNeeded > 0)
		cli_execute("Buy " + qtyNeeded + " " + it);
	use(qty,it);
}

/*******************************************************
*					wobble()
*	Gets a specified buff from a specified item. 
*	Optimizes for your current turns and turns remaining
*	of the buff if you have it already.
/*******************************************************/
void wobble(effect buff, item source, int turns)
{
	int turnsToGet = my_adventures() - have_effect(buff);
	getUse(turnsToGet/turns + 1, source);
}

void diner()
{
	if (my_class() == $class[pastamancer])
		use_skill(1,$skill[Bind Lasagmbie]);
	if (have_effect($effect[temporary blindness]) > 0)
		cli_execute("hottub");
	if (have_effect($effect[temporary blindness]) > 0)
		cli_execute("shrug temporary blindness");
	if (have_effect($effect[everything looks yellow]) == 0)
		cli_execute("viviYellowRay.ash");
	// Get ready to adventure
	use_familiar($familiar[Stocking Mimic]);
	// Buffs
	wobble($effect[Wasabi Sinuses], $item[Knob Goblin nasal spray], 10);
	wobble($effect[Merry Smithsness], $item[Flaskfull of Hollow], 150);
	// Have fam, outfit, etc
	use_familiar($familiar[Stocking Mimic]);
	cli_execute("outfit Farming1");
	cli_execute("autoattack Farming");
	// Get early stuff done; CSA fire-starter kit & Bjorn familiar drops
 	adventure(45,$location[Sloppy seconds Diner]);
	cli_execute("outfit Farming2");
	adventure(15,$location[Sloppy seconds Diner]);
}

void main()
{
	diner();
}
script "viviBarf.ash"

/*******************************************************
*					viviBarf()
*	Spends adventures at Barf Mountain to get meat.
*	Also gets in daily Conspiracy Island quest in, and
*	tries to perform a yellow ray every 100 adventures.
/*******************************************************/
int numberologyCount = 0;
int digitizeCount = 1;
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
*					getEat()
*	Retrives & eats a specified quantity of a food.
/*******************************************************/
void getEat(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	if (qtyNeeded > 0 && it == $item[Karma shawarma])
		buy($coinmaster[The SHAWARMA Initiative],qty,it);
	else if (qtyNeeded > 0 && it == $item[dinsey food-cone])
		buy($coinmaster[The Dinsey Company Store],qty,it);
	else if (qtyNeeded > 0)
		cli_execute("Buy " + qtyNeeded + " " + it);
	eat(qty,it);
}

/*******************************************************
*					wobble()
*	Gets a specified buff from a specified item. 
*	Optimizes for your current turns and turns remaining
*	of the buff if you have it already.
/*******************************************************/
void wobble(effect buff, item source, int turns)
{
	int effectTurns = my_adventures() - have_effect(buff);
	getUse(effectTurns/turns + 1, source);
}

/*******************************************************
*					numberology(int digits)
*	Tries to get a numberology outcome with the ending
*	digits input. Only enter 2 digits.
/*******************************************************/
void numberology(int digits)
{
	if(cli_execute("numberology " + digits))
		numberologyCount+=1;
}

void digitizeUpdate()
{
	cli_execute("autoattack Copy3");
	if (digitizeCount == 1)
		visit_url("place.php?whichplace=chateau&action=chateau_painting");
	else if (digitizeCount == 2)
		use(1,$item[photocopied monster]);
	run_combat();
	digitizeCount+=1;
	cli_execute("autoattack Farming");
}

void farm()
{
	// Buffs
	wobble($effect[Wasabi Sinuses], $item[Knob Goblin nasal spray], 10);
	wobble($effect[Merry Smithsness], $item[Flaskfull of Hollow], 150);
	wobble($effect[How to Scam Tourists], $item[How to Avoid Scams], 20);
	
	cli_execute("pool 1");
	cli_execute("pool 1");
	
	// Pantsgiving fullness
	getUse(1,$item[milk of magnesium]);
	adventure(2,$location[Barf Mountain]);
	getEat(1,$item[ice rice]);
	adventure(2,$location[Barf Mountain]);
	getEat(1,$item[jumping horseradish]);
	
	// Finish adventuring -- Loop at final location while YRing
	cli_execute("outfit Farming3");
	while (my_adventures() > 0)
	{	
		if(numberologyCount < 2)
			numberology(69);
		/* if (digitizeCount < 3 && get_property("_sourceTerminalDigitizeMonsterCount").to_int() >= 5)
			digitizeUpdate(); */
		if (have_effect($effect[everything looks yellow]) == 0)
			cli_execute("viviYellowRay.ash");
		adventure(1,$location[Barf Mountain]);
	}
	// Assorted item maintenance
	autosell(item_amount($item[meat stack]),$item[meat stack]);
	use(item_amount($item[bag of park garbage])-5,$item[bag of park garbage]);
}

void main()
{
	farm();
}
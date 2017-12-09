script "viviEatDrink.ash"

/*******************************************************
*					viviEatDrink()
*	Fills stomach, spleen, and liver with daily 
*	consumables.
/*******************************************************/

/*******************************************************
*					getChew()
*	Retrieves & uses a specified quantity of a spleen item.
/*******************************************************/
void getChew(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	if (qtyNeeded > 0)
		cli_execute("Buy " + qtyNeeded + " " + it);
	chew(qty,it);
}
/*******************************************************
*					getDrink()
*	Retrives & drinks a specified quantity of a drink.
/*******************************************************/
void getDrink(int qty, item it)
{
	int qtyNeeded = qty - item_amount(it);
	if (it == $item[Broberry brogurt] && qtyNeeded > 0) // Don't mall these
		buy($coinmaster[The Frozen Brogurt Stand],qty,it);
	else if (it == $item[Dinsey Whinskey] && qtyNeeded > 0)
		buy($coinmaster[The Dinsey Company Store],qty,it);
	else if (qtyNeeded > 0)
		cli_execute("Buy " + qtyNeeded + " " + it);
	drink(qty,it);
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

void eatDrink()
{
	// Barrelgod Buff for potentially extra adventures
	if (my_class() == $class[Turtle Tamer])
	{
		visit_url("da.php?barrelshrine=1");
		visit_url("choice.php?pwd&whichchoice=1100&option=4");
	}

	// Drink
	equip($item[Brimstone Beret]);
	use_skill(3,$skill[The Ode to Booze]);
	getDrink(1,$item[Broberry brogurt]);
	getDrink(1,$item[ambitious turkey]);
	getDrink(5,$item[perfect cosmopolitan]);
	drink(1,$item[cold one]);
	cli_execute("shrug ode");
	equip($item[crumpled felt fedora]);
	
	// Spleen
	getChew(3,$item[Grim fairy tale]);
	getUse(1,$item[mojo filter]);
	getChew(1,$item[Grim fairy tale]);
	//getUse(1,$item[Choco-Crimbot]);
	//getUse(1,$item[chocolate turtle totem]);

	// Eat
	getUse(2,$item[milk of magnesium]);
	eat(1,$item[spaghetti breakfast]);
	getEat(4,$item[jumping horseradish]);
	getEat(1,$item[Karma shawarma]);
	while ((fullness_limit() - my_fullness() > 4) && (get_property("_timeSpinnerMinutesUsed").to_int() < 8))
		cli_execute("timespinner eat karma shawarma");
	getEat((fullness_limit() - my_fullness() ) / 5,$item[Karma shawarma]);
}
void main()
{
	eatDrink();
}
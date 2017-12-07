script "viviBrickos.ash"

/*******************************************************
*					viviBrickos()
*	Fights 10 bricko boozes in order to get free item 
*	drops from familiars.
/*******************************************************/

void brickos(familiar f)
{
	// Fail-safe setup
	cli_execute("autoattack Farming");
	cli_execute("outfit FreeDrops");
	if (my_class() == $class[pastamancer])
		use_skill(1,$skill[Bind Spice Ghost]);
	
	use_familiar(f);
	
	if (item_amount($item[bricko eye brick]) < 10)
		buy(10,$item[bricko eye brick],300);
	while (get_property("_brickoFights").to_int() < 10)
		cli_execute("use bricko ooze");
}

void main()
{
	familiar fam = $familiar[Fist Turkey];
	brickos(fam);
}
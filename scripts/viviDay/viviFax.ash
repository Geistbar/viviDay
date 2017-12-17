script "viviFax.ash"

/*******************************************************
*					viviFax()
*	
/*******************************************************/

void fax()
{
	// Clan check
	if (get_clan_name() != "Thud!")
		cli_execute("/whitelist Thud!");

	if (item_amount($item[photocopied monster]) == 0)
		cli_execute("faxbot embezzler");

	take_stash(1,$item[spooky putty sheet]);
	cli_execute("outfit Meat1");
	
	cli_execute("ccs Meat1");
	cli_execute("autoattack Meat1");
	cli_execute("familiar Obtuse Angel");
	visit_url("place.php?whichplace=chateau&action=chateau_painting");
	run_combat();
	cli_execute("outfit Meat2");
	cli_execute("autoattack Meat2");
	cli_execute("familiar Hobo Monkey");
 	cli_execute("ccs Meat2");
	use(1,$item[Spooky Putty monster]);
	use(1,$item[Spooky Putty monster]);
	use(1,$item[Spooky Putty monster]);
	use(1,$item[Spooky Putty monster]);
	cli_execute("ccs default");
	cli_execute("autoattack Farming");
	use(1,$item[Spooky Putty monster]);
	use(1,$item[photocopied monster]);
	put_stash(1,$item[spooky putty sheet]);
}

void main()
{
	fax();
}
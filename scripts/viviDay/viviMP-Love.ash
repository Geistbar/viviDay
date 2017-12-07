script "viviMPLOVE.ash"

/*******************************************************
*					viviMPLOVE()
*	Does mana buffs and hits the love tunnel. Uses
*	free MP restores to cast librams.
/*******************************************************/

void loveTunnel(int a, int b, int c)
{
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(1);
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(1);
	run_combat();
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(a);
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(1);
	run_combat();
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(b);
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(1);
	run_combat();
	visit_url("place.php?whichplace=town_wrong&action=townwrong_tunnel");
	run_choice(c);
	run_choice(2);
}

void MPbuffs()
{
	// Clan check
	if (get_clan_name() != "Thud!")
		cli_execute("/whitelist Thud!");

	// Setup
	cli_execute("outfit mp");
	use_familiar($familiar[disembodied hand]);
	cli_execute("cast * Summon Resolutions");
	cli_execute("ballpit");
	cli_execute("telescope high");
	cli_execute("spacegate vaccine 2"); // 50% myst
	
	take_stash(1,$item[Platinum Yendorian Express Card]);
	use(1,$item[Platinum Yendorian Express Card]);
	put_stash(1,$item[Platinum Yendorian Express Card]);
	use_skill(5,$skill[Summon BRICKOs]);
	cli_execute("cast * Summon Resolutions");
	
	// Last MP refill
	use(1,$item[License to Chill]);
	cli_execute("cast * Summon Taffy");
	
	// Get more mana from Love Tunnel
	cli_execute("outfit lovetunnelMYS");
	cli_execute("autoattack LoveTunnel");
	use_familiar($familiar[Golden Monkey]);
	loveTunnel(3,2,2); // Third choice for each
	cli_execute("cast * Summon Love Song");
}

void main()
{
	MPbuffs();
}
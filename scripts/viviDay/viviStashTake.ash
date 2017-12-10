script "viviStashTake.ash"

/*******************************************************
*					viviStashTake()
*	Removes items from the stash for daily farming.
/*******************************************************/

void main()
{
	// Clan check
	if (get_clan_name() != "Thud!")
		cli_execute("/whitelist Thud!");
		
	take_stash(1,$item[Pantsgiving]);
	take_stash(1,$item[Loathing Legion Knife]);
	
	use_familiar($familiar[Stocking Mimic]);
	cli_execute("fold loathing legion helicopter");
	cli_execute("equip Loathing Legion helicopter");
}
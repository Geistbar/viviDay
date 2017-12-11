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
		
	// Return items to stash
	use_familiar($familiar[Stocking Mimic]); // Safety precaution
	cli_execute("unequip loathing legion helicopter");
	cli_execute("equip Bag of many confections");
	cli_execute("fold loathing legion knife");
	//if (equipped_item($slot[pants]) == $item[Pantsgiving])
	equip($slot[pants],$item[none]);
		
	put_stash(1,$item[Pantsgiving]);
	put_stash(1,$item[Loathing Legion Knife]);
}
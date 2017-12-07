script "useMeatItems.ash"

/*******************************************************
*					useMeatItems()
*	Uses or autosells assorted items that give meat.
/*******************************************************/

boolean[item] meatItems = $items[collection of tiny spooky objects, duct tape wallet, fat wallet, flytrap pellet, old coin purse, old leather wallet, pixel coin, pixellated moneybag, shiny stones, solid gold jewel, stolen meatpouch, Warm Subject gift certificate, dungeon dragon chest, CSA discount card, black pension check];

boolean[item] autosellItems = $items[dense meat stack, massive gemstone, dollar-sign bag, half of a gold tooth, pile of gold coins, meat stack, gold nuggets];

void useMeatItems()
{
	foreach it in meatItems
		use(item_amount(it), it);
	foreach it in autosellItems
		autosell(item_amount(it),it);
}

void main()
{
	useMeatItems();
}
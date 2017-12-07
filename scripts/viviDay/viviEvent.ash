script "viviEvent.ash"

/*******************************************************
*					viviEvent()
*	For doing special adventures during an event.
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

void eventAdv()
{
	cli_execute("autoattack Farming");
	if (item_amount($item[worksite credentials]) == 0)
		take_closet(1,$item[worksite credentials]);
	if (item_amount($item[mafia organizer badge]) == 0)
		take_closet(1,$item[mafia organizer badge]);
	
	cli_execute("outfit lyle");
	cli_execute("familiar Jumpsuited Hound Dog");
	cli_execute("cast 3 musk of the moose");
	cli_execute("cast 2 Carlweather's Cantata of Confrontation");
	getUse(3,$item[handful of pine needles]);
		
	cli_execute("adv 21 monorail work site");
	
	cli_execute("outfit Farming2"); // Just need to change outfit
	put_closet(item_amount($item[worksite credentials]),$item[worksite credentials]);
	put_closet(item_amount($item[mafia organizer badge]),$item[mafia organizer badge]);
	
	cli_execute("shrug Carlweather's Cantata of Confrontation");
}

void main()
{
	eventAdv();
}
script "viviFreeRun.ash"

/*******************************************************
*					viviFreeRun()
*	Uses daily free runaways in order to try and
*	encounter an Ultra Rare. Also makes use of 
*	pickpocket to ensure some profit no matter what.
/*******************************************************/

/*******************************************************
*					availableRunaways()
*	Calculates available runaways with stomping boots.
/*******************************************************/
int availableRunaways()
{
	int usedRuns = get_property("_banderRunaways").to_int();
	int weight = familiar_weight($familiar[Pair of Stomping Boots])	+ numeric_modifier("familiar weight");
	int maxRuns = weight / 5;
	
	return (maxRuns - usedRuns);
}
/*******************************************************
*					bootsRun()
*	Runs away a specified quantity of times from 
*	specified place.
/*******************************************************/
void bootsRun(int times, location place)
{
	int iterations = 0;
	while (iterations < times)
	{
		iterations+= 1;
		adv1(place,-1,"");
	}
}

void freeRun()
{
	location place = $location[A Mob of Zeppelin Protesters];
	
  	cli_execute("outfit BootRunaway");
	cli_execute("autoattack BootRunaway");
	use_familiar($familiar[Pair of Stomping Boots]);
	equip($slot[familiar],$item[Ittah bittah hookah]);
	
	bootsRun(availableRunaways(),place);
	equip($slot[acc3],$item[belt of loathing]);
	bootsRun(availableRunaways(),place);
	equip($slot[acc2],$item[over-the-shoulder Folder Holder]);
	bootsRun(availableRunaways(),place);
	equip($item[gnawed-up dog bone]);
	bootsRun(availableRunaways(),place);
	equip($item[old school flying disc]);
	bootsRun(availableRunaways(),place);
	equip($slot[familiar],$item[sugar shield]);
	bootsRun(availableRunaways(),place);
}

void main()
{
	freeRun();
}
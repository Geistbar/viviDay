script "RobDay.ash"
import <zlib.ash>
/*******************************************************
*	RobDay.ash
*
*	Farms at spring break beach with stocking mimic.
*	Automatically handles:
*	- Pantsgiving
*	- Free runaways
*	- Fax, chateau painting, rain-doh, spooky putty
*	- PYEC
*	- Free bricko fights
*	- Chibi buff
*	- Yellow rays
*	- Bjorn buddy swapping
*	- All consumption
*	- Rollover outfit, overdrinking
*
*	The script also calculates daily expenses, profits
*	and meat per adventure.
*
*	WARNING: Script is fine tuned for a specific
*	character. It will not work for you if you are
*	not that character.
*
/*******************************************************/

/*******************************************************
*					Scriptwide Variables
/*******************************************************/
int[item] invStart;
float meatStart;
float advStart;
int[item] invStop;
float meatStop;
float advStop;
int[item] invStartPvP;
int[item] invStopPvP;
float itemGain = 0;
float itemLoss = 0;
int itemGainPvP = 0;
float mpa;
float mpaTotal;
int wins;
int fights;
boolean spiderFought = FALSE;
boolean calcUniverse = TRUE;
/*-----------------------------------------------------
*					Sub-Functions Start
/*----------------------------------------------------*/
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
/*******************************************************
*					getChibiBuff()
*	Gets free buff from Chibi. Revives Chibi if dead.
/*******************************************************/
void getChibiBuff()
{
	if (!contains_text(visit_url("inv_use.php?pwd&whichitem=5908"),"Have a ChibiChat"))
	{
		visit_url("inv_use.php?pwd&whichitem=5908");
		visit_url("choice.php?pwd&option=7&whichchoice=627");
		visit_url("inv_use.php?pwd&whichitem=5925");
		visit_url("choice.php?pwd&option=1&whichchoice=633&chibiname=your butt");
	}
	else if (item_amount($item[ChibiBuddy&trade; (on)]) == 0)
	{
		visit_url("inv_use.php?pwd&whichitem=5925");
		visit_url("choice.php?pwd&option=1&whichchoice=633&chibiname=your butt");
	}
	visit_url("inv_use.php?pwd&whichitem=5908");
	visit_url("choice.php?pwd&option=5&whichchoice=627");
}
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
	{
		if (!take_closet(qtyNeeded,$item[Karma shawarma]))
			buy($coinmaster[The SHAWARMA Initiative],qty,it);
	}
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
	{
		if ((it == $item[knob goblin pet-buffing spray]) || (it == $item[Knob Goblin nasal spray]))
		{
			if (item_amount(it) < 100)
				chat_private("Giestbar","I'm low on " + it);
		}
		else
			cli_execute("Buy " + qtyNeeded + " " + it);
	}
	use(qty,it);
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
	if (calcUniverse)
	{
		if (cli_execute("numberology " + digits))
			calcUniverse = FALSE;
	}
}
/*-----------------------------------------------------
*					Main-Functions Start
/*----------------------------------------------------*/
void buffs(boolean consume)
{
	// Get MP & smithsness just in case
	if (my_mp() < 400)
		restore_mp(400); // Get some MP just in case
	if (have_effect($effect[Merry Smithsness]) == 0)
		use(1,$item[Flaskfull of Hollow]); // Make sure smithsness is running
	if (consume)
	{
		equip($item[Brimstone Beret]); // Song limit
		use_skill(1,$skill[The Ode to Booze]);
		getDrink(1,$item[Broberry brogurt]);
		getDrink(1,$item[ambitious turkey]);
		cli_execute("shrug ode");
		equip($item[crumpled felt fedora]);
	}
	use(1,$item[Defective Game Grid token]);
	cli_execute("ballpit");
	cli_execute("telescope high");
	cli_execute("outfit mp");
	use_familiar($familiar[disembodied hand]);
	cli_execute("cast * resolution");
	//getUse(1,$item[red snowcone]);
	//getUse(1,$item[Gene Tonic: Constellation]);
	//getUse(1,$item[pink candy heart]);
	getUse(1,$item[Knob Goblin pet-buffing spray]);
	getUse(1,$item[Knob Goblin nasal spray]);
	//getUse(1,$item[resolution: be wealthier]);
	//getUse(1,$item[Meat-inflating powder]);
	getChibiBuff();
	cli_execute("summon 2");
	cli_execute("hatter 22");
	cli_execute("concert 2");
	cli_execute("clanhop.ash (The Clan Of Intelligent People)");
	cli_execute("pool 1");
	cli_execute("clanhop.ash (Thud!)");
	use(1,$item[The Legendary Beat]);
	if (consume)
	{
		getUse(2,$item[milk of magnesium]);
		visit_url("da.php?barrelshrine=1");
		visit_url("choice.php?pwd&whichchoice=1100&option=4");
	}
	take_stash(1,$item[Platinum Yendorian Express Card]);
	use(1,$item[Platinum Yendorian Express Card]);
	put_stash(1,$item[Platinum Yendorian Express Card]);
	if (consume)
		getEat((fullness_limit() - my_fullness() ) / 5,$item[Karma shawarma]);
	cli_execute("cast * resolution");
}
/*******************************************************
*					brickos()
*	Fights brickos and changes familiars as appropraite.
/*******************************************************/
void brickos()
{
	cli_execute("autoattack Beach");
 	if (item_amount($item[bricko ooze]) < 10)
	{
		int qty = 10 - item_amount($item[bricko ooze]);
		buy(qty,$item[bricko ooze]);
	}
	//use_skill(1,$skill[Bind Spice Ghost]);
	use_familiar($familiar[Fist Turkey]);
	while (get_property("_brickoFights").to_int() < 10)
	{
		cli_execute("use bricko ooze");
	}
}
/*******************************************************
*					fax()
*	Was taking up too much space. Kills embezzlers.
/*******************************************************/
void fax()
{
	if (item_amount($item[photocopied monster]) == 0)
		cli_execute("faxbot embezzler");
	cli_execute("outfit Meat1");
	
	/*
	cli_execute("ccs Meat1");
	cli_execute("familiar Obtuse Angel");
	visit_url("place.php?whichplace=chateau&action=chateau_painting");
	visit_url("fight.php");
	run_combat();
	cli_execute("outfit Meat2");
	cli_execute("familiar Hobo Monkey");
 	cli_execute("ccs Meat2");
	use(1,$item[Spooky Putty monster]);
	use(1,$item[Spooky Putty monster]);
	use(1,$item[Spooky Putty monster]);
	use(1,$item[Spooky Putty monster]);
	cli_execute("ccs default");
	use(1,$item[Spooky Putty monster]);
	use(1,$item[photocopied monster]);
	*/
	
	cli_execute("ccs Meat3");
	cli_execute("familiar Obtuse Angel");
	visit_url("place.php?whichplace=chateau&action=chateau_painting");
	run_combat();
	cli_execute("ccs default");
	cli_execute("familiar Hobo Monkey");
	use(1,$item[photocopied monster]);
}
/*******************************************************
*					freeRun()
*	Was taking up too much space. Runs away a bunch of
*	times. Switches gear to get optimal returns.
/*******************************************************/
void freeRun(location place)
{
  	cli_execute("outfit BootRunaway1");
	cli_execute("autoattack BootRunaway1");
	use_familiar($familiar[Pair of Stomping Boots]);
	equip($slot[familiar],$item[Ittah bittah hookah]);
	//bjornify_familiar($familiar[Spooky Pirate Skeleton]);
	
	bootsRun(availableRunaways(),place);
	equip($slot[acc3],$item[belt of loathing]);
	bootsRun(availableRunaways(),place);
	equip($slot[acc2],$item[over-the-shoulder Folder Holder]);
	bootsRun(availableRunaways(),place);
	equip($item[gnawed-up dog bone]);
	bootsRun(availableRunaways(),place);
	equip($item[old-school flying disc]);
	bootsRun(availableRunaways(),place);
	equip($slot[familiar],$item[sugar shield]);
	bootsRun(availableRunaways(),place);
}
/*******************************************************
*					yellowRay()
*	Does a yellow ray at the inner wolf gym. If no
*	adventures are consumed, the function assumes
*	that this means the end of skid row has been reached
*	and thus uses a new grimstone mask and calls itself
*	again.
/*******************************************************/
void yellowRay()
{
	// Check to see if you reached the end of the gym
	if (contains_text(visit_url("questlog.php?which=1"),"Time Left: 3")) 
	{
		visit_url("inv_use.php?pwd&whichitem=7061");
		visit_url("choice.php?pwd&option=2&whichchoice=829");
	}
	cli_execute("autoattack yellowRay");
	use_familiar($familiar[He-Boulder]);
	adventure(1,$location[The Inner Wolf Gym]);
}
void diner()
{
 	// Consumables
	equip($item[Brimstone Beret]);
	use_skill(2,$skill[The Ode to Booze]);
	getDrink(5,$item[perfect cosmopolitan]);
	drink(1,$item[cold one]);
	getChew(3,$item[Grim fairy tale]);
	getUse(1,$item[mojo filter]);
	getChew(1,$item[Grim fairy tale]);
	getUse(1,$item[Choco-Crimbot]);
	getUse(1,$item[chocolate turtle totem]);
	cli_execute("shrug ode");
	equip($item[crumpled felt fedora]);
	//use_skill(1,$skill[Bind Lasagmbie]);
	if (have_effect($effect[temporary blindness]) > 0)
		cli_execute("hottub");
	if (have_effect($effect[temporary blindness]) > 0)
		cli_execute("shrug temporary blindness");
	if (have_effect($effect[everything looks yellow]) == 0)
		yellowRay();
	// Get ready to adventure
	use_familiar($familiar[Stocking Mimic]);
	if (have_effect($effect[Merry Smithsness]) < 20)
		use(1,$item[Flaskfull of Hollow]); // Make sure smithsness is running
	// Buffs
	wobble($effect[Wasabi Sinuses], $item[Knob Goblin nasal spray], 10);
	wobble($effect[Merry Smithsness], $item[Flaskfull of Hollow], 150);
	// Have fam, outfit, etc
	use_familiar($familiar[Stocking Mimic]);
	cli_execute("outfit Beach1");
	cli_execute("autoattack Beach");
	// Get early stuff done; CSA fire-starter kit
	adventure(30,$location[Sloppy seconds Diner]);
	cli_execute("outfit Beach2");
	adventure(15,$location[Sloppy seconds Diner]);
	// Eat food now
	getUse(1,$item[milk of magnesium]);
	getEat(1,$item[snow crab]);
	adventure(2,$location[Sloppy seconds Diner]);
	getEat(1,$item[snow crab]);
	adventure(17,$location[Sloppy seconds Diner]);
}
void farm()
{
	// Buffs
	wobble($effect[Wasabi Sinuses], $item[Knob Goblin nasal spray], 10);
	wobble($effect[Merry Smithsness], $item[Flaskfull of Hollow], 150);
	wobble($effect[How to Scam Tourists], $item[How to Avoid Scams], 20); // Buff for mtn
	cli_execute("clanhop.ash (The Clan Of Intelligent People)");
	cli_execute("pool 1");
	cli_execute("pool 1");
	cli_execute("clanhop.ash (Thud!)");
	// Finish adventuring -- Loop at final location while YRing
	cli_execute("outfit mountain1"); // Last outfit change!
	while (my_adventures() > 0)
	{	
		numberology(69);	// Get my extra adventures
		if (have_effect($effect[everything looks yellow]) == 0)
		{
			yellowRay();
			use_familiar($familiar[Stocking Mimic]);
			cli_execute("autoattack Beach");
		}
		adventure(1,$location[Barf Mountain]);
	}
	// Assorted item maintenance
	autosell(item_amount($item[meat stack]),$item[meat stack]);
	use(item_amount($item[bag of park garbage])-5,$item[bag of park garbage]);
}
void rollover()
{
	// Put stuff in store and closet
	put_shop(0,0,$item[Five Second Energy&trade;]);
	put_shop(0,0,$item[Jerks' Health&trade; Magazine]);
	put_closet(item_amount($item[black snowcone]),$item[black snowcone]);
	put_closet(item_amount($item[fish juice box]),$item[fish juice box]);
	put_closet(item_amount($item[rubber nubbin]),$item[rubber nubbin]);
	//cli_execute("PvPItemCheck.ash");
	// Get ready for rollover
	cli_execute("faxbot embezzler");
	equip($item[Pantsgiving]);
	while (get_property("timesRested").to_int() < total_free_rests())
		cli_execute("rest");
	// Return items to stash
	use_familiar($familiar[Stocking Mimic]); // Safety precaution
	cli_execute("unequip loathing legion helicopter");
	cli_execute("equip Bag of many confections");
	cli_execute("fold loathing legion knife");
	if (equipped_item($slot[pants]) == $item[pantsgiving])
		equip($slot[pants],$item[none]);
	put_stash(1,$item[loathing legion knife]);
	put_stash(1,$item[pantsgiving]);
	// Rest of shit
	use_familiar($familiar[Magic Dragonfish]);
	cli_execute("swim sprints");
	cli_execute("use Oscus's neverending soda");
	cli_execute("cast * resolutions");
	cli_execute("outfit Rollover");
	use_skill(1,$skill[The Ode to Booze]);
	take_stash(1,$item[tiny plastic sword]);
	cli_execute("mix cherry bomb");
	drink(1,$item[cherry bomb]);
	put_stash(1,$item[tiny plastic sword]);
	cli_execute("shrug ode");
	cli_execute("hottub");
}
/*******************************************************
*					dataStart()
*	Stores basic inventory and meat data for calculating
*	meat per adventure. For use at start of day.
/*******************************************************/
void dataStart()
{
	invStart = get_inventory();
	foreach eqSlot in $slots[acc1, acc2, acc3, off-hand, weapon, hat, pants, back, shirt]
		invStart[equipped_item(eqSlot)]+=1;
	meatStart = my_meat();
	advStart = my_turncount();
}
/*******************************************************
*					dataEnd()
*	Stores basic inventory and meat data for calculating
*	meat per adventure. For use at end of day.
/*******************************************************/
void dataEnd()
{
	meatStop = my_meat();
	advStop = my_turncount();
	invStop = get_inventory();
	foreach eqSlot in $slots[acc1, acc2, acc3, off-hand, weapon, hat, pants, back, shirt]
		invStop[equipped_item(eqSlot)]+=1;
}
/*******************************************************
*					dataProcess()
*	Processes the stored data from dataStart and dataEnd
*	along with two PvP variables in order to calculate
*	daily profit.
/*******************************************************/
void dataProcess()
{
	print(""); // Formatting
	foreach it in invStop
	{
		if ((invStop[it] > invStart[it]) && (it == $item[rubber nubbin]))
			spiderFought = TRUE;
		if (it  == $item[ChibiBuddy&trade; (on)])
			invStop[it]=invStart[it];	// Script doesn't handle chibi buddies well
		if (it == $item[ChibiBuddy&trade; (off)])
			invStop[it]=invStart[it];	// Script doesn't handle chibi buddies well
		if (it == $item[stinky cheese eye])
			invStop[it] = invStart[it];
		if (invStop[it] > invStart[it])
			itemGain += historical_price(it)*(invStop[it]-invStart[it]);
		if (invStop[it] < invStart[it])
			itemLoss += historical_price(it)*(invStop[it]-invStart[it])*-1;
		if (historical_price(it)*(invStop[it]-invStart[it]) > 100000)
			print("Expensive item: " + (invStop[it]-invStart[it]) + " " + it, "purple");
		if (historical_price(it)*(invStart[it]-invStop[it]) > 100000)
			print("Expensive item lost: " + (invStart[it]-invStop[it]) + " " + it, "purple");
	}
	foreach it in invStopPvP
	{
		if (it == $item[buddy bjorn])
			invStopPvP[it] = invStartPvP[it];
		if (invStopPvP[it] > invStartPvP[it])
		{
			itemGainPvP+=historical_price(it)*(invStopPvP[it]-invStartPvP[it]);
			if ((invStopPvP[it]-invStartPvP[it])*historical_price(it) > 10000)
				print("PvP Prize! : " + it + " @ " + rnum(historical_price(it)), "maroon");
		}
	}
	mpa = (meatStop - meatStart) / (advStop - advStart);
	mpaTotal = mpa + ((itemGain - itemLoss) / (advStop - advStart));
	
	// PvP Detail!
	string[int] logs = session_logs(1);
	string[int] lines = logs[0].split_string();
	foreach line in lines
	{
		if (contains_text(lines[line], "and won the PvP fight,"))
			wins+=1;
	}
}
/*******************************************************
*					Functions Stop
/*******************************************************/
void main()
{
	dataStart(); // Store inventory, meat, and adventures for calculations
 	cli_execute("viviStartDay.ash");
	take_stash(1,$item[pantsgiving]);
	take_stash(1,$item[loathing legion knife]);
	cli_execute("fold loathing legion helicopter");
	use_familiar($familiar[Stocking Mimic]);
	equip($slot[familiar],$item[loathing legion helicopter]);
 	buffs(TRUE);
	freeRun($location[A Mob of Zeppelin Protesters]);
	brickos(); 
	fax();
	cli_execute("autoVolcano.ash");
	cli_execute("autoConspiracy.ash");
	cli_execute("autoGlacier.ash");
	diner();
	farm();
	dataEnd(); // Store new inventory, meat, and turncount
	/* invStartPvP = get_inventory();
	fights = pvp_attacks_left();
	cli_execute("robPvP.ash");
	invStopPvP = get_inventory(); */
	rollover();
	
	// How much meat did I make?
	dataProcess();
	// Print everything out
	if (spiderFought)
		print("Vivilein was naughty today.", "green");
	print(""); // Formatting
	print("Total item expenses: " + rnum(itemLoss,2) + " meat", "red");
	print("Total item gain: " + rnum(itemGain,2) + " meat", "green");
	print("Total meat gained (base): " + rnum(meatStop - meatStart,2) + " meat", "navy");
	print("Total meat gained (items): " + rnum((meatStop - meatStart)+itemGain-itemLoss,2) + " meat", "navy");
	print("Meat per adventure (base): " + rnum(mpa,2), "navy");
	print("Meat per adventure (items): " + rnum(mpaTotal,2), "navy");
	print(""); // Formatting
	print("Total PvP item profits: " + rnum(itemGainPvP,2) + " meat", "maroon");
	print(""); // Formatting
	print("You won " + wins + " out of " + fights + " PvP fights!", "maroon");
}
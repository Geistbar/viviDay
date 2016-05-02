script autoDayStart.ash;
import <zlib.ash>
// Does beginning of day stuff that Mafia still doesn't do automatically

// Store inventory, meat, and adventures for calculations
int[item] invStart = get_inventory();
foreach eqSlot in $slots[acc1, acc2, acc3, off-hand, weapon, hat, pants, back, shirt]
	invStart[equipped_item(eqSlot)]+=1;

// Buy elemental wads if necessary
foreach it in $items[cold wad, hot wad, stench wad, sleaze wad, spooky wad, twinkly wad]
	if (item_amount(it) < 3)
	{
		int amountToBuy = 3 - item_amount(it);
		cli_execute("buy " + amountToBuy + " " + it);
	}

// Skills
if (have_skill($skill[Summon Holiday Fun!]))
	use_skill($skill[Summon Holiday Fun!]);
if (have_skill($skill[Rainbow Gravitation]))
	use_skill(3,$skill[Rainbow Gravitation]);
if (have_skill($skill[Summon Annoyance]))
	use_skill($skill[Summon Annoyance]);
if (have_skill($skill[Canticle of Carboloading]))
	use_skill($skill[Canticle of Carboloading]);
if (have_skill($skill[Summon Carrot]))
	use_skill($skill[Summon Carrot]);
if (have_skill($skill[Summon Kokomo Resort Pass]))
	use_skill($skill[Summon Kokomo Resort Pass]);
if (have_skill($skill[Summon Geeky Gifts]))
	cli_execute("cast 1 Summon Geeky Gifts");
 
// Bittycar Meatcar
use(1,$item[BittyCar MeatCar]);
cli_execute("Make 3 Potion of punctual companionship");
cli_execute("shower ice");
cli_execute("cast 10 taffy");
//use(5,$item[Jerks' Health&trade; Magazine]);
//use(1,$item[CSA fire-starting kit]);

// Get DNA Potions Cause Lazy
visit_url("campground.php?action=dnapotion");
visit_url("campground.php?action=dnapotion");
visit_url("campground.php?action=dnapotion");

cli_execute("breakfast");

visit_url("place.php?whichplace=chateau&action=chateau_desk2");
//buy(11,$item[mummy wrapping],130);

// Get funfunds from maintenance
if (item_amount($item[bag of park garbage]) == 0)
	buy(1,$item[bag of park garbage]);
visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels");
visit_url("choice.php?pwd&option=6&whichchoice=1067");

// Tea Tree
cli_execute("teatree voraci");
put_closet(item_amount($item[cuppa voraci tea]),$item[cuppa voraci tea]);

// Draw 3 cards
cli_execute("cheat island; cheat recall; cheat mickey; autosell 1952 Mickey Mantle card");

// Barrel god
// visit_url("da.php?barrelshrine=1");
// visit_url("choice.php?pwd&whichchoice=1100&option=4");

// Store new inventory, meat, and turncount
int[item] invStop = get_inventory();
foreach eqSlot in $slots[acc1, acc2, acc3, off-hand, weapon, hat, pants, back, shirt]
	invStop[equipped_item(eqSlot)]+=1;
// How much meat did I make?
float itemGain = 0;
float itemLoss = 0;
foreach it in invStop
{
	if (invStop[it] > invStart[it])
		itemGain += historical_price(it)*(invStop[it]-invStart[it]);
	if (invStop[it] < invStart[it])
		itemLoss += historical_price(it)*(invStop[it]-invStart[it])*-1;
}
print("Total item expenses: " + rnum(itemLoss,2) + " Meat","red");
print("Total item gain: " + rnum(itemGain,2) + " Meat","green");

print("The fifth cheapest Mr. A is: " + rnum(mall_price($item[Mr. Accessory])) + " meat.","red");
print("The fifth cheapest Uncle Buck is: " + rnum(mall_price($item[Uncle Buck])) + " meat.","red");
print("The fifth cheapest rubber nubbin is: " + rnum(mall_price($item[rubber nubbin])) + " meat.","red");
print("By using this script you agree to the scriptract. Thanks!","green");
print("Go mine at the velvet mine. By.. ugh.. hand. So peasant-like.");
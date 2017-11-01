script autoDayStart.ash;
import <zlib.ash>
// Does beginning of day stuff that Mafia still doesn't do automatically

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

// Get DNA Potions Cause Lazy
visit_url("campground.php?action=dnapotion");
visit_url("campground.php?action=dnapotion");
visit_url("campground.php?action=dnapotion");

// Source Terminal
cli_execute("terminal extrude food");
cli_execute("terminal extrude food");
cli_execute("terminal extrude food");

// Sea Jelly
use_familiar($familiar[Space Jellyfish]);
visit_url("place.php?whichplace=thesea&action=thesea_left2");
run_choice(1);

cli_execute("breakfast");

visit_url("place.php?whichplace=chateau&action=chateau_desk2");

// Get funfunds from maintenance
if (item_amount($item[bag of park garbage]) == 0)
	buy(1,$item[bag of park garbage]);
visit_url("place.php?whichplace=airport_stench&action=airport3_tunnels");
visit_url("choice.php?pwd&option=6&whichchoice=1067");

// Tea Tree
cli_execute("teatree royal");
put_closet(item_amount($item[cuppa royal tea]),$item[cuppa royal tea]);

// Draw 3 cards
cli_execute("cheat island; cheat recall; cheat mickey; autosell 1952 Mickey Mantle card");

// Cop bucks
cli_execute("Detective Solver.ash");

// Barrel god.
// visit_url("da.php?barrelshrine=1");
// visit_url("choice.php?pwd&whichchoice=1100&option=4");
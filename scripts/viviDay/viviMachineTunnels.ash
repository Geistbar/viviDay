script "vivuMachineTunnels.ash"

/*******************************************************
*					vivuMachineTunnels()
*	Gets daily five free combats from the machine tunnels.
/*******************************************************/
void machineTunnels()
{
	// Fail-safe setup
	cli_execute("autoattack MachineElf");
	cli_execute("outfit FreeDrops");
		
	use_familiar($familiar[Machine Elf]);
	
	while(get_property("_machineTunnelsAdv").to_int() < 5)
		adv1($location[The Deep Machine Tunnels],-1,"");

	//int times = 0;
	
	//while((get_property("_machineTunnelsAdv").to_int() < 5) && (times < 5))
	//{
	//	adv1($location[The Deep Machine Tunnels],-1,"");
	//	times+=1;
	//}
}

void main()
{
	machineTunnels();
}
/*
	File: fn_clothing_dive.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration file for Altis Diving Shop.
*/
private["_filter"];
_filter = param [0,0,[0]];
/*Classname, Custom Display name (use nil for Cfg->DisplayName, price*/

/*Shop Title Name*/
ctrlSetText[3103,"Steve's Diving Shop"];

switch (_filter) do
{
	/*Uniforms*/
	case 0:
	{
		[
			["U_O_Wetsuit","Camo Wetsuit",2000],
			["U_I_Wetsuit","Green Wetsuit",2000],
			["U_B_Wetsuit","Black Wetsuit",2000]
		];
	};
	
	/*Hats*/
	case 1:
	{
		[
		];
	};
	
	/*Glasses*/
	case 2:
	{
		[
			["G_Diving","Black Diving Goggles",50],
			["G_I_Diving","Green Diving Goggles",50]
		];
	};
	
	/*Vest*/
	case 3:
	{
		[
			["V_RebreatherIR","Camo Rebreather",5000],
			["V_RebreatherIA","Green Rebreather",5000],
			["V_RebreatherB","Black Rebreather",5000]
		];
	};
	
	/*Backpacks*/
	case 4:
	{
		[
		];
	};
};
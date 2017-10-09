/*
	File: fn_copDefault.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Default cop configuration.
*/
/*Strip the player down*/
RemoveAllWeapons player;
{player removeMagazine _x;} foreach (magazines player);
removeUniform player;
removeVest player;
removeBackpack player;
removeGoggles player;
removeHeadGear player;
{
	player unassignItem _x;
	player removeItem _x;
} foreach (assignedItems player);

/*Load player with default cop gear.*/
if(undercover) then {
	player addWeapon "hgun_Rook40_F";
	player forceAddUniform "U_C_Poor_1";
	player addGoggles "G_Aviator";
	player addHeadGear "H_StrawHat";
	player addItem "NVGoggles";
	player assignItem "NVGoggles";
} else {
	player addUniform "U_Rangemaster";
	player addWeapon "hgun_P07_snds_F";
	player addGoggles "G_Shades_Black";
	player addHeadgear "H_Cap_police";
	player addItem "NVGoggles_OPFOR";
	player assignItem "NVGoggles_OPFOR";
	player addBackpack "B_Kitbag_sgg";
	unitBackpack player setObjectTextureGlobal [0,""];
};
player addVest "V_TacVest_blk_POLICE";
player addMagazines ["16Rnd_9x21_Mag",4];
player addItem "ItemMap";
player assignItem "ItemMap";
player addItem "ItemRadio";
player assignItem "ItemRadio";
player addItem "ItemCompass";
player assignItem "ItemCompass";
player addItem "ItemGPS";
player assignItem "ItemGPS";
player addItem "ItemWatch";
player assignItem "ItemWatch";

[] call life_fnc_equipGear;
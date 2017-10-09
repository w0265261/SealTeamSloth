/*
	File: fn_medicLoadGear.sqf
	Author: Skeith
	
	Description:
	Used for loading medic gear loadout.
*/
private["_allowedItems","_loadout","_primary","_launcher","_handgun","_magazines","_uniform","_vest","_backpack","_items","_primitems","_secitems","_handgunitems","_uitems","_vitems","_bitems","_handle"];

_uniform = "U_I_CombatUniform";
_items = ["ItemMap","ItemCompass","ItemWatch","ItemGPS","NVGoggles","H_Cap_red","ItemRadio"];
_bitems = ["Toolkit","Medikit"];

/*Strip the unit down*/
RemoveAllWeapons player;
{player removeMagazine _x;} foreach (magazines player);
removeUniform player;
removeVest player;
removeBackpack player;
removeGoggles player;
removeHeadGear player;
removeAllAssignedItems player;
player addBackpack "B_Kitbag_sgg";
unitBackpack player setObjectTextureGlobal [0,""];
{
	player unassignItem _x;
	player removeItem _x;
} foreach (assignedItems player);

/*Add the gear*/
if(_uniform != "") then {_handle = [_uniform,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};};
{_handle = [_x,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};} foreach _items;
{[_x,true,true,false,false] call life_fnc_handleItem;} foreach (_bitems); 
if(!(str player in["medic_2","medic_3","medic_4"])) then {player addVest "V_TacVestIR_blk"; player addheadgear "H_Cap_marshal"};
player addWeapon "Binocular";
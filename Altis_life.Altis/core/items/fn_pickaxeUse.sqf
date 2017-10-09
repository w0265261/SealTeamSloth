/*
	File: fn_pickaxeUse.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main functionality for pickaxe in mining.
*/
closeDialog 0;
private["_mine","_itemWeight","_diff","_itemName","_val"];
if(isNil "life_action_gathering") then {life_action_gathering = false;};
if(life_action_gathering) exitWith {}; /*Action is in use, exit to prevent spamming.*/
life_action_gathering = true;
switch (true) do
{
	case (player distance (getMarkerPos "lead_1") < 30): {_mine = "copperore"; _val = 2;};
	case (player distance (getMarkerPos "iron_1") < 30): {_mine = "ironore"; _val = 2;};
	case (player distance (getMarkerPos "salt_1") < 75) : {_mine = "salt"; _val = 4;};
	case (player distance (getMarkerPos "sand_1") < 50) : {_mine = "sand"; _val = 5;};
	case (player distance (getMarkerPos "diamond_1") < 50): {_mine = "diamond"; _val = 1;};
	case (player distance (getMarkerPos "oil_1") < 40) : {_mine = "oilu"; _val = 1;};
	case (player distance (getMarkerPos "oil_2") < 40) : {_mine = "oilu"; _val = 1;};
	case (player distance (getMarkerPos "rock_1") < 50): {_mine = "rock"; _val = 2;};
	case (player distance (getMarkerPos "gold_1") < 50): {_mine = "goldore"; _val = 2;};
	case (player distance (getMarkerPos "coal_1") < 50): {_mine = "coalore"; _val = 2;};
	case (player distance (getMarkerPos "phos_1") < 50): {_mine = "phos"; _val = 2;};
	case (player distance (getMarkerPos "hydro_1") < 50): {_mine = "hydro"; _val = 2;};
	default {_mine = "";};
};
if(_mine == "") exitWith {};
if(!isNull objectParent player) exitWith {hint localize "STR_ISTR_Pick_MineVeh";};

_diff = [_mine,_val,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_diff == 0) exitWith {hint localize "STR_NOTF_InvFull"};
if(!(life_action_inUse)) then {
PlaySound "pickaxe";
};
life_action_inUse = true;
for "_i" from 0 to 2 do
{
	player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
	waitUntil{animationState player != "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";};
	sleep 2.5;
};

if(([true,_mine,_diff] call life_fnc_handleInv)) then
{
	_itemName = [([_mine,0] call life_fnc_varHandle)] call life_fnc_varToStr;
	titleText[format[localize "STR_ISTR_Pick_Success",_itemName,_diff],"PLAIN"];
};


life_action_inUse = false;
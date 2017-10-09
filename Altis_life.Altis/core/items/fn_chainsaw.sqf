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
	case (player distance (getMarkerPos "logs_1") < 30): {_mine = "log"; _val = 1;};
	default {_mine = "";};
};

/*Mine check*/
if(_mine == "") exitWith {};
if(!isNull objectParent player) exitWith {};

_diff = [_mine,_val,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_diff == 0) exitWith {hint "Your inventory is full."};
life_action_inUse = true;
for "_i" from 0 to 2 do
{
	player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
	waitUntil{animationState player != "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";};
	sleep 5;
};
if(([true,_mine,_diff] call life_fnc_handleInv)) then
{
	_itemName = [([_mine,0] call life_fnc_varHandle)] call life_fnc_varToStr;
	titleText[format["You have logged %2 %1",_itemName,_diff],"PLAIN"];
};
life_action_inUse = false;
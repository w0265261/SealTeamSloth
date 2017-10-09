/*
	File: fn_pickaxeUse.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Main functionality for pickaxe in mining.
*/
closeDialog 0;
private["_mine","_itemWeight","_diff","_itemName","_val","_array","_random","_catch"];
/*Weighting catches toward legal*/
/*_catch = ["fcrab","fcrabp","mcrab","mcrabs"] call BIS_fnc_selectRandom;*/
_dice = round(random 100);
switch (true) do {
	/*10% chance for female pregnant crab*/
	case (_dice < 10): {
		_catch = "fcrabp";
	};
	/*30% chance for male small crab*/
	case (_dice < 40): {
		_catch = "mcrabs";
	};
	/*45% chance for female crab*/
	case (_dice < 85): {
		_catch = "fcrab";
	};
	/*15% chance for male crab*/
	default {
		_catch = "mcrab";
	};
};

/*ceil used to ensure you don't get 0*/
_val = ceil(random 3);

switch (true) do
{
	case (player distance (getMarkerPos "crab_1") < 350): {_mine = _catch; _val;};
	case (player distance (getMarkerPos "crab_2") < 350): {_mine = _catch; _val;};
	case (player distance (getMarkerPos "crab_3") < 350): {_mine = _catch; _val;};
	case (player distance (getMarkerPos "crab_4") < 350): {_mine = _catch; _val;};

	default {_mine = "";};
};

hint titleText ["Dropping Pot...", "PLAIN"];
life_action_inUse = true;
sleep 1.5;

/*Mine check*/
if(_mine == "") exitWith {hint "You need to be in the crabbing zone!"; life_action_inUse = false;};
/*if(vehicle player !isKindOf "Ship") exitWith {hint "You can only crab from the boat!";};*/


_diff = [_mine,_val,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_diff == 0) exitWith {hint "Your inventory is full."; life_action_inUse = false;};

sleep 10;

if(([true,_mine,_diff] call life_fnc_handleInv)) then
{
	_itemName = [([_mine,0] call life_fnc_varHandle)] call life_fnc_varToStr;
	titleText[format["You got %2 %1",_itemName,_diff],"PLAIN"];
};

life_action_inUse = false;

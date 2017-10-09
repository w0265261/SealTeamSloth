closeDialog 0;
/*
	File: fn_searchWreck.sqf
	Author: Mike "Revir" Berlin
	Compatibility edits for STS by Kevin W.
	Description:
	Searches shipwrecks for the items within the _items array.
*/
private["_sum","_items","_random"];
_items = [];
for "_i" from 1 to 20 do { _items pushBack "silver"; };
for "_i" from 1 to 30 do { _items pushBack "lockpick"; };
for "_i" from 1 to 25 do { _items pushBack "zip"; };
for "_i" from 1 to 7 do { _items pushBack "oilp"; };
for "_i" from 1 to 2 do { _items pushBack "cocainep"; };
for "_i" from 1 to 10 do { _items pushBack "doubl"; };
for "_i" from 1 to 3 do { _items pushBack "pearl"; };
for "_i" from 1 to 2 do { _items pushBack "ruby"; };
_items pushBack "diamondf";


if (playerSide == west) exitWith {hint "Cops cannot search wrecks."};
if (player distance (nearestObject[player,"Land_UWreck_FishingBoat_F"]) > 30) exitWith {titleText["You need to be closer to a ship wreck to use the excavator.","PLAIN"]};
if ((getPosASL player) select 2 > -20) exitWith {titleText["The excavator requires more water pressure (you're not deep enough).","PLAIN"]};
if (life_carryWeight >= (life_maxWeight - 1)) exitWith { hint "Your inventory is too full!"; };
titleText["Searching Wreck...","PLAIN"];
life_action_inUse = true;

while{life_carryWeight < life_maxWeight} do {
	if (life_carryWeight >= (life_maxWeight - 1)) exitWith {hint "Your inventory is now full!";};
	if (speed player >= 1) exitWith {hint "excavation aborted due to movement!"; }; 
	_random = _items select round (random ((count _items)-1));
	if (([true,_random,1] call life_fnc_handleInv)) then
	{
		sleep 4;
		titleText["You have collected some treasure from the wreck.","PLAIN"];
		titleFadeOut 1;
	}
	else
	{ 
	titleText["You failed to find anything this time!","PLAIN"];
	titleFadeOut 1;
	};
};
life_action_inUse = false;
/*Check for legitimacy*/
if(!(license_civ_excav)) then {
license_civ_excav = true;
[2] call SOCK_fnc_updatePartial;
};

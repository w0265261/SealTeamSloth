/*
	File: fn_blindfoldRemove.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Removes blindfold from the target
*/

_unit = cursorTarget;
if(life_carryWeight < (life_maxWeight - 2)) then {
life_inv_blindfold = life_inv_blindfold + 1;
life_carryWeight = life_carryWeight + 2;
};
_unit setVariable ["blindfolded", nil, true];
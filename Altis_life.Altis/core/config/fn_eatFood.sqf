/*
	File: fn_eatFood.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main handling system for eating food.
	*Needs to be revised and made more modular and more indept effects*
*/
private["_food","_val","_sum"];
_food = param [0,"",[""]];
if(_food == "") exitWith {};

if([false,_food,1] call life_fnc_handleInv) then {
	switch (_food) do
	{
		case "apple": {_val = 10};
		case "rabbit":{ _val = 20};
		case "salema": {_val = 30};
		case "ornate": {_val = 25};
		case "mackerel": {_val = 30};
		case "tuna": {_val = 60};
		case "mullet": {_val = 60};
		case "catshark": {_val = 80};
		case "turtle": {_val = 80};
		case "turtlesoup": {_val = 70};
		case "donuts": {_val = 30};
		case "tbacon": {_val = 40};
		case "peach": {_val = 10};
		
		/*Drugs*/
		case "marijuana": {_val = -20};
	};

	_sum = life_hunger + _val;
	if(_sum > 100) then {_sum = 100;};
	life_hunger = _sum;
};
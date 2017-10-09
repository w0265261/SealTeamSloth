/*
	File: fn_enableActions.sqf
	
	Description:
	Enable actions for several seconds.
*/

if (!life_show_actions) then
{
	[] spawn life_fnc_setupActions;
};
life_show_actions = true;
if (time > life_action_time) exitWith { life_action_time = time + 9; };
life_action_time = time + 9;

waitUntil { life_action_time < time };

{ player removeAction _x; } forEach STS_actions;
STS_actions = [];
life_show_actions = false;
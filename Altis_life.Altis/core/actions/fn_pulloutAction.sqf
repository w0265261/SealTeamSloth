/*
	File: fn_pulloutAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pulls civilians out of a car if it's stopped.
*/
private["_crew"];
_crew = crew cursorTarget;
if(speed cursorTarget > 1) exitWith {hint "You couldn't pull them out, as the vehicle is moving!"; };
{
		 _x setVariable ["Escorting",false,true];
		[_x] remoteExec ["life_fnc_pulloutVeh",_x,false];
} foreach _crew;
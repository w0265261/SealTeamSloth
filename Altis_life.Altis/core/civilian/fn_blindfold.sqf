/*
	File: fn_blindfold.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Apply a blindfold to the player
*/

_unit = cursorTarget;
if (!isPlayer _unit || !alive _unit || !(_unit getVariable ["zipTie",false])) exitWith { hint "Your target isn't a living, restrained, player!  You can't blindfold that."; };

if(!([false,"blindfold",1] call life_fnc_handleInv)) exitWith {};

systemChat format["You've applied a blindfold to %1.", name _unit];

[player] remoteExec ["life_fnc_blindfolded",_unit];
/*
	File: fn_unzip.sqf
*/
private["_unit"];
_unit = param [0,Objnull,[Objnull]];
if(isNull _unit || !(_unit getVariable["zipTie",false])) exitWith {};

[_unit, "zip_tie",30] remoteExec ["life_fnc_playSound",0];
_unit setVariable ["zipTie",false,true];
_unit setVariable["Escorting",FALSE,TRUE];

detach _unit;
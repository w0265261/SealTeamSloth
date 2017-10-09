/*
	File: fn_arrestAction.sqf
	
	Description:
	Arrests the targeted person.
*/
private["_unit","_id"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit) exitWith {}; /*Not valid*/
if(isNil "_unit") exitwith {}; /*Not Valid*/
if(!(_unit isKindOf "Man")) exitWith {}; /*Not a unit*/
if(!isPlayer _unit) exitWith {}; /*Not a human*/
//if(!(_unit getVariable "restrained")) exitWith {}; /*He's not restrained.*/
//if(side _unit != civilian) exitWith {}; /*Not a civ*/
if(isNull _unit) exitWith {}; /*Not valid*/
if(player distance _unit > 4) exitWith {};

detach _unit;
[_unit,false] call life_fnc_jailDialog;
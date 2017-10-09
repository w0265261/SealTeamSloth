/*
	File: fn_stopEscorting.sqf
	
	Description:
	ASFSDFHAGFASF
*/
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit) exitWith {}; /*Not valid*/
if(!(_unit getvariable["Escorting",false])) exitWith {}; /*He's not being Escorted.*/
if(isNull _unit) exitWith {}; /*Not valid*/
detach _unit;
_unit setVariable["Escorting",false,true];
life_escort = ObjNull;
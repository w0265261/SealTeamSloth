#include <macro.h>
/*
	File: fn_adminJail.sqf
	Author: Kevin

	Description:
	Special admin punishment
*/
if(__GETC__(style) < 1) exitWith {};

private["_unit"];
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};

[_unit,false] call life_fnc_adminArrest;  
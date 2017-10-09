#include <macro.h>
/*
	File: fn_adminRestrain.sqf
	Author: Kevin

	Description:
	Restrains the chosen player for a talking to
*/
if(__GETC__(style) < 1) exitWith {};

private["_unit"];
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};

[0,format["%1 was restrained by the admin %2!",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",0];
hint "You have restrained the target player, please remember to unrestrain them!";
[player] remoteExec ["life_fnc_adminRestrainAction",_unit];
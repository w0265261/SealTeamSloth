#include <macro.h>
/*
	File: fn_adminRevive.sqf
	Author: Kevin

	Description:
	Revives the chosen player.
*/
if(__GETC__(style) == 0) exitWith {closeDialog 0;};

private["_unit"];
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};

[3,format["%1 was revived by the admin %2!",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",0];
/*Tells the server that an admin revive has taken place.*/
[player] remoteExec ["life_fnc_adminReviveAction",_unit];
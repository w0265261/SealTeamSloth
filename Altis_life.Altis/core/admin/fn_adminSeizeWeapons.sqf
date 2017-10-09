#include <macro.h>
/*
	File: fn_adminSeizeWeapons.sqf
	Author: Kevin

	Description:
	Removes the chosen player's weapons.
*/
if(__GETC__(style) < 1) exitWith {};

private["_unit"];
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
if(_unit == player) exitWith {hint "Why would you remove your own weapons?";};

[0,format["%1 had their weapons seized by Admin %2! Let this be a lesson to you, %1. DO NOT RDM.",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",0];  
/*Tells the server that an admin action has taken place.*/
[player] remoteExec ["life_fnc_adminSeizeAction",_unit];
titleText [format["Seized weapons from %1",_unit getVariable["realname",name _unit]],"PLAIN"];
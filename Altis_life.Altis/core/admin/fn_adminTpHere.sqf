#include <macro.h>
/*
	File: fn_adminTpHere.sqf
	Author: ColinM9991
	Edited and Modified by CDawg for STS
	Description:
	Teleport selected player to you.
*/
if(__GETC__(style) < 3) exitWith {hint "This is only for Senior Moderator use";};

private["_target"];
_target = lbData[2902,lbCurSel (2902)];
_target = call compile format["%1", _target];
if(isNil "_target") exitwith {};
if(isNull _target) exitWith {};
if(_target == player) exitWith {hint "You touch yourself enough already!";};
Jail_Target setVariable["jailBreak",true,true];
_target setPosATL (getPosATL player);
hint format["You have teleported %1 to your location",_target getVariable["realname",name _target]];
[3,format["%2 has brought %1 to his location",_target getVariable["realname",name _target],profileName]] remoteExec ["life_fnc_broadcast",0];
Jail_Target spawn
{
	sleep 1;
	_this setVariable["jailBreak",false,true];
};
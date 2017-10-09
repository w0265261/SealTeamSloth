#include <macro.h>
/*
	File: fn_adminTpHere.sqf
	Author: Kevin Webb
	Description:
	Teleports yourself to the selected player. Just switched around the TPtoME script to be TPtoHIM
*/
if(__GETC__(style) < 3) exitWith {hint "This is only for seniors to use";};

private["_target"];
_target = lbData[2902,lbCurSel (2902)];
_target = call compile format["%1", _target];
if(isNil "_target") exitwith {};
if(isNull _target) exitWith {};
if(_target == player) exitWith {hint "You can not teleport yourself to yourself";};
_pos = getPosATL _target;
_pos set[0,(_pos select 0) + 2];
vehicle player setPosATL _pos;
if(!(player getVariable["invis",false])) then {
[3,format["%2 has teleported to %1",_target getVariable["realname",name _target],profileName]] remoteExec ["life_fnc_broadcast",0]; };
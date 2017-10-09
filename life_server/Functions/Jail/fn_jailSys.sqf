/*
	File: fn_jailSys.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	I forget?
*/
private["_unit","_bad","_id","_ret"];
_unit = param [0,objNull,[objNull]];
if(isNull _unit) exitWith {};
_bad = param [1,false,[false]];
_jailTime = param [2,20,[0]];
_admin = param [3,false,[false]];
//_id = owner _unit;

_ret = [_unit] call life_fnc_wantedPerson;
[_ret,_bad,_jailTime,_admin] remoteExec ["life_fnc_jail",_unit,false];
/*
	File: fn_robAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the robbing process?
*/
private["_target"];
_target = cursorTarget;

/*Error checks*/
if(isNull _target) exitWith {};
if(!isPlayer _target) exitWith {};
[player] remoteExec ["life_fnc_robPerson",_target,false];
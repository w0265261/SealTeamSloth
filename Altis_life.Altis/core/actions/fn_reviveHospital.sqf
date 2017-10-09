/*
	File: fn_reviveHospital.sqf
	Author: Bobbus
	
	Description:
	Doesn't matter, will be revised later.
*/
private["_near","_furthest","_drAlan"];
_drAlan = _this select 0;
_multiplier = switch(life_rules select 2) do {
	case 0: {1};
	case 1: {0.5};
	case 2: {0};
};
if(life_myFunds < (100 * _multiplier) && playerSide != independent && !(_this select 3)) exitWith {hint format["You do not have $%1 for your friend to be revived.",100 * _mutliplier]};
_near = nearestObjects[getPos _drAlan,["Man"],5];
_furthest = objNull;
{
	if (_x getVariable ["unconscious",false]) then {
		_furthest = _x;
	};
} forEach _near;

if(isNull _furthest || !isPlayer _furthest) exitWith {titleText["Your friend needs to be within 5m to be healed.","PLAIN"]};

titleText[format["Doctor Alan will begin reviving %1...",name _furthest],"PLAIN"];
[player,true] remoteExec ["life_fnc_reviveAction",_furthest,false];
if(playerSide == independent) then { ["cash","add",400] call life_fnc_handlePaper; hint "You have been rewarded $400 for your work as a medic!"; } else {
if(!(_this select 3)) then {
["atm","take",100 * _multiplier] call life_fnc_handlePaper;}; };
if(life_rules select 2 > 0) then {systemChat format["Healthcare expenses have been reduced thanks to President %1!",life_rules select 5]};
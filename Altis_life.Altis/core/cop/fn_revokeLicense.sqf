/*
	File: fn_revokeLicence.sqf
	
	Description:
	Handles the removal of any license
*/
_unit = cursorTarget;
if(side _unit == west) exitWith { hint "You don't have the right to revoke the license of a Police Officer!"; };
if(isNull _unit) exitWith {};
if(player distance _unit > 4) exitWith {};

[player] remoteExec ["life_fnc_revokeLicenseAction",_unit];
hint format["You have revoked %1's Driver's License.",name cursorTarget];

/*
	Function file for Armed Assault
	Created by: DirtDiver for STS
*/

/*
	File: fn_licenseSearchAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the searching process.
*/
private["_unit"];
_unit = cursorTarget;
if(isNull _unit) exitWith {};
hint "Checking licenses.";
sleep 2;
if(player distance _unit > 5 || !alive player || !alive _unit) exitWith {hint "Cannot search that person."};
[player] remoteExec ["life_fnc_licenseCheck",_unit];

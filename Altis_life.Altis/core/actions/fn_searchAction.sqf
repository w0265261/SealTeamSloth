/*
	File: fn_searchAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the searching process.
*/
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit) exitWith {};
if(call life_coplevel < 1 && playerSide == west) exitWith {hint "No Searching for Public Cops. Contact a Whitelisted Officer."};
hint localize "STR_NOTF_Searching";
sleep 2;
if(player distance _unit > 5 || !alive player || !alive _unit) exitWith {hint localize "STR_NOTF_CannotSearchPerson"};
[player] remoteExec ["life_fnc_searchClient",_unit];
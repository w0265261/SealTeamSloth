/*
	File: fn_questionDistributor.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Questions the drug Distributor and sets the sellers wanted.
*/
private["_sellers","_names","_charge"];
_charge = "";
if((_this select 0) in [poacher_1]) then {_charge = "poach"} else {_charge = "484"};
_sellers = (_this select 0) getVariable["sellers",[]];
if(count _sellers == 0) exitWith {hint "No one has sold to this distributor recently."}; /*No data.*/
life_action_inUse = true;
_names = "";
{
	[_x select 0,_x select 1,_charge,[name player]] remoteExec ["life_fnc_wantedAdd",2];
	_names = _names + format["%1<br/>",_x select 1];
} foreach _sellers;

hint parseText format["The following people have been selling to this dealer recently.<br/><br/>%1",_names];
(_this select 0) setVariable["sellers",[],true];
life_action_inUse = false;
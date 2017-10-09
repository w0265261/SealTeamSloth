/*
	File: fn_grantBH.sqf
	Author: Kevin

	Description:
	Allows the chosen player to purchase a bounty hunter's license only in this particular server session.
*/
if(call style < 1 && call life_coplevel < 5) exitWith {};
private["_unit"];
_admin = param[0];
_unit = if(_admin) then {lbData[2902,lbCurSel (2902)]} else {lbData[1338,lbCurSel (1338)]};
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
if(_unit getVariable["criminal",false]) exitWith {hint "This person cannot be approved for BH status right now, as they were arrested during this server session.";};

[0,format["%1 was approved for bounty hunter status by %2",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",0]; 
_unit setVariable["approved",true,true];
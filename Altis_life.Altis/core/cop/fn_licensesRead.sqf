/*
	File: fn_licensesRead.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Outprints the licenses.
*/
private["_licenses","_civ"];
_civ = param [0,"",[""]];
_licenses = param [1,(localize "STR_Cop_NoLicenses"),[""]];

hint parseText format["<t color='#FF0000'><t size='2'>%1</t></t><br/><t color='#FFD700'><t size='1.5'>" +(localize "STR_Cop_Licenses")+ "</t></t><br/>%2",_civ,_licenses];

if(_civ getVariable["realname",name _civ] != name _civ) then {
	[0,format["%1's real identity was revealed to be %2!",_civ getVariable "realname",name _civ]] remoteExec ["life_fnc_broadcast",0];
	_civ setVariable["realname",name _civ,true]; 
	[getPlayerUID _civ,""] remoteExecCall ["DB_fnc_updateFakeName",2];
};
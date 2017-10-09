/*
	File: fn_revokeLicenceAction.sqf
	
	Description:
	For now, removes the client's driver license.
*/
private["_type","_cop"];
_type = _this select 0;
_cop = param [0,Objnull,[Objnull]];

license_civ_driver = false;
hint format["%1 has revoked your driver's license!",name _cop];
[2] call SOCK_fnc_updatePartial;
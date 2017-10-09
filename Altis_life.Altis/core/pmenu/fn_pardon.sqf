#include <macro.h>
/*
	File: fn_pardon.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pardons the selected player.
*/
private["_display","_list","_uid","_name","_unit"];
disableSerialization;
_display = findDisplay 2400;
_list = _display displayCtrl 2402;
_data = lbData[2401,(lbCurSel 2401)];
_data = call compile format["%1", _data];
if(isNil "_data") exitWith {};
if(typeName _data != "ARRAY") exitWith {};
if(count _data == 0) exitWith {};
if(life_governor && governorPardon) exitWith {hint "You have already used your pardon for this session."};
_unit = ObjNull;
if(count _data == 3) exitWith {
	_uid = _data select 2;
	_index = [_uid,life_wanted_list] call fnc_index;
	_fullList = life_wanted_list select _index;
	_otherIndex = [_data select 1, _fullList select 2] call fnc_index;
	_int = _fullList select 3;
	_int = _int - ((_data select 1) call fnc_findChargeAmt);
	_fullList set[3,_int];
	_charges = _fullList select 2;
	if(count _charges == 1) exitWith {hint "This is the only charge on the list, pardon them completely instead"};
	_charges set[_otherIndex,-1];
	_charges = _charges - [-1];
	_fullList set[2,_charges];
	life_wanted_list set[_index,_fullList];
	publicVariable "life_wanted_list";
	lbDelete [2401,(lbCurSel 2401)];
	[_fullList,_uid] remoteExecCall ["TON_fnc_saveBounties",2];
};
_uid = _data select 1;
if(_uid == getPlayerUID player && life_governor) exitWith {hint "You cannot pardon yourself, abusive bastard..."};
_name = _data select 0;
_president = if(life_governor) then {"President "} else {""};
[0,format[_president+"%1 has pardoned %2 from the wanted list",profileName, _name]] remoteExec ["life_fnc_broadcast",0];
[_uid,player] remoteExec ["life_fnc_wantedPardon",2];
{if(getPlayerUID _x == _uid) then {_unit = _x;}; if(!isNull _unit) exitWith {}; } forEach playableUnits;
[false] remoteExec ["life_fnc_amIWanted",_unit];
closeDialog 0;
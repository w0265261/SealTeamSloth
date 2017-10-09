#include <macro.h>
/*
	File: fn_vehInvSearch.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Searches the vehicle for illegal items.
*/
private["_vehicle","_vehicleInfo","_value"];
_vehicle = cursorTarget;
if(isNull _vehicle) exitWith {};
if(!((_vehicle isKindOf "Air") OR (_vehicle isKindOf "Ship") OR (_vehicle isKindOf "LandVehicle"))) exitWith {};

_vehicleInfo = _vehicle getVariable ["Trunk",[]];
if(count _vehicleInfo == 0) exitWith {hint localize "STR_Cop_VehEmpty"};
_newTrunk = _vehicleInfo select 0;
_newWeight = _vehicleInfo select 1;
_value = 0;
{
	_var = _x select 0;
	_val = _x select 1;
	
	_index = [_var,life_illegal_items] call fnc_index;
	if(_index != -1) then
	{
		_value = _value + (_val * ((life_illegal_items select _index) select 1));
		_newTrunk = _newTrunk - [_x];
		_newWeight = _newWeight - (([_x select 0] call life_fnc_itemWeight) *(_x select 1));
	};
} foreach (_vehicleInfo select 0);

if(_value > 0) then
{
	[0,format[localize "STR_NOTF_VehContraband",[_value] call life_fnc_numberText]] remoteExec ["life_fnc_broadcast",0];
	hint "You found illegal contraband within this vehicle!";
	["atm","add",_value] call life_fnc_handlePaper;
	_vehicle setVariable["Trunk",[_newTrunk,_newWeight],true];
}
	else
{
	if(_vehicle getVariable["drugRunner",false]) then {hint "You find the remnants of an illegal, synthetic substance within this vehicle...";
	
	} else {
		hint localize "STR_Cop_NoIllegalVeh";
};
};
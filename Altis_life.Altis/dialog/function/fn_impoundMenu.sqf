#include <macro.h>
/*
	File: fn_impoundMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sets up the garage dialog.
*/
private["_vehicles","_control"];
disableSerialization;
_vehicles = param [0,[],[[]]];

ctrlShow[2803,false];
ctrlShow[2830,false];
waitUntil {!isNull (findDisplay 2800)};

if(count _vehicles == 0) exitWith
{
	ctrlSetText[2811,localize "STR_Garage_NoVehicles"];
};

_control = ((findDisplay 2800) displayCtrl 2802);
lbClear _control;


{
	_vehicleInfo = [_x select 1] call life_fnc_fetchVehInfo;

	_customName = format["%1",_x select 3];

	if(_customName == "") then {
		_control lbAdd (_vehicleInfo select 3);
	} else {
		_control lbAdd (_customName);
	};
	_tmp = [_x select 1,_x select 2,_x select 4, _x select 5, _x select 6, _x select 7];
	_tmp = str(_tmp);
	_control lbSetData [(lbSize _control)-1,_tmp];
	_control lbSetPicture [(lbSize _control)-1,_vehicleInfo select 2];
	_control lbSetValue [(lbSize _control)-1,_x select 0];
} foreach _vehicles;

ctrlShow[2810,false];
ctrlShow[2811,false];
if(playerSide != civilian) then {ctrlShow[1007,false]};
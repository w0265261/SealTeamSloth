#include <macro.h>
/*
	File: fn_unimpound.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Yeah... Gets the vehicle from the garage.
*/
private["_vehicle","_vid","_pid","_unit","_price"];
disableSerialization;
if(lbCurSel 2802 == -1) exitWith {hint localize "STR_Global_NoSelection"};
_vehicle = lbData[2802,(lbCurSel 2802)];
_vehicle = (call compile format["%1",_vehicle]) select 0;
_vid = lbValue[2802,(lbCurSel 2802)];
_pid = getPlayerUID player;
_unit = player;

if(isNil "_vehicle") exitWith {hint localize "STR_Garage_Selection_Error"};

_price = [_vehicle,life_vehicle_buy] call fnc_index;

if(_price == -1) then {systemChat "BAD PRICE, report to developer"; _price = 1000;} else {_price = ((life_vehicle_buy select _price) select 1) / 30};
if(playerSide == independent) then { _price = _price / 8; };
if(playerSide == west && _classname in ["C_Heli_Light_01_civil_F","B_Heli_Transport_03_unarmed_F"]) then {_price = _price / 10};
if(life_myGarage) then {_price = 0; };
_price = (_price * __GETC__(life_vip_discount));
if(life_myfunds < _price) exitWith {hint "It appears you do not have enough money for the storage fee!";};

if(typeName life_garage_sp == "ARRAY") then {
	[_vid,_pid,life_garage_sp select 0,_unit,_price,life_garage_sp select 1,_vehicle] remoteExec ["TON_fnc_spawnVehicle",2];
} else {
	[_vid,_pid,(getMarkerPos life_garage_sp),_unit,_price,markerDir life_garage_sp,_vehicle] remoteExec ["TON_fnc_spawnVehicle",2];
};

hint "Fetching vehicle...";

["atm","take",_price] call life_fnc_handlePaper;
life_myGarage = false;
closeDialog 0;
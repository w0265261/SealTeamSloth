#include <macro.h>
/*
	File: fn_adminImpound.sqf
	Author: Kevin Webb
	
	Description:
	instantly garages the vehicle
*/
if(__GETC__(style) < 1) exitWith {};
private["_vehicle","_type","_time","_price","_vehicleData","_upp","_ui","_progress","_pgText","_cP","_veh"];
_vehicle = cursorTarget;
_check = _vehicle getVariable "building";
if(!isNil "_check") exitWith {};

_vehicleData = _vehicle getVariable["vehicle_info_owners",[]];
if(count _vehicleData == 0) exitWith {deleteVehicle _vehicle; }; /*bad vehicle?*/
_vehicleName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

_type = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
[_vehicle,true,player] remoteExec ["TON_fnc_vehicleStore",2];
[0,format[localize "STR_NOTF_HasImpounded",profileName,(_vehicleData select 0) select 1,_vehicleName]] remoteExec ["life_fnc_broadcast",0];
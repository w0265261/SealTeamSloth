/*
	File: fn_vehicleInsurance.sqf
	Author: Kevin Webb
	Description:
	Sets the vehicle to alive and inactive, spawned by the insurance script.
*/
private["_vehicle","_dbInfo","_isPerm","_player"];
_vehicle = param [0,objNull,[objNull]];
_isPerm = param [1,false,[false]];
_player = param [2,ObjNull,[ObjNull]];
if(isNull _vehicle || isNil "_vehicle") exitWith {};
_dbInfo = _vehicle getVariable ["dbInfo",[]];
if(count _dbInfo == 0) exitWith {};
_vehicle setVariable["isInsured",true,true];
if(_isPerm) then {
	_uid = _dbInfo select 0;
	_plate = _dbInfo select 1;
	[_vehicle,true] remoteExec ["life_fnc_gpsTracker",_player,false];
	_query = format["UPDATE vehicles SET insured='1' WHERE pid='%1' AND plate='%2'",_uid,_plate];
	
	[_query,1] call DB_fnc_asyncCall;
};
/*waitUntil {sleep 1; !alive _vehicle};
if(isNull _vehicle) exitWith {};
_vehicle setVariable["dbInfo",[],true];
sleep 10;
if(!isNull _vehicle && !isNil "_vehicle") then {
	deleteVehicle _vehicle;
};
_query = format["UPDATE vehicles SET active='0', alive='1', insured='0' WHERE pid='%1' AND plate='%2'",_uid,_plate];

[_query,1] call DB_fnc_asyncCall;
*/
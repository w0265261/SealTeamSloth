/*
fn_gpsTracked.sqf
Kevin Webb
Another database query
*/
_vehicle = _this;
if(isNull _vehicle) exitWith {};

_dbInfo = _vehicle getVariable["dbInfo",[]];
if(count _dbInfo == 0) exitWith {};
_uid = _dbInfo select 0;
_plate = _dbInfo select 1;

_query = format["UPDATE vehicles SET tracked='1' WHERE pid='%1' AND plate='%2'",_uid,_plate];


[_query,1] call DB_fnc_asyncCall;
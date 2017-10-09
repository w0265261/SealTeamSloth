/*
Kevin Webb
fn_updateVehColor.sqf
Yet another database update
*/
_vehicle = param[0];
_texture = param[1];
_info = _vehicle getVariable "dbInfo";
_uid = _info select 0;
_plate = _info select 1;
_query = format["UPDATE vehicles SET color='%1' WHERE pid='%2' AND plate=%3",_texture,_uid,_plate];
[_query,1] call DB_fnc_asyncCall;
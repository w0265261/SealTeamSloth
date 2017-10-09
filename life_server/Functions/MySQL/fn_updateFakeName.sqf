/*
Kevin Webb
fn_updateFakeName.sqf
sends it to the database...
*/
_uid = param[0];
_name = param[1];
_query = format["UPDATE players SET fakeName='%1' WHERE playerid='%2'",_name,_uid];
[_query,1] call DB_fnc_asyncCall;
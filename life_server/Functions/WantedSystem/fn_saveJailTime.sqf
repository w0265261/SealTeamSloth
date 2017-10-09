/*
File: fn_saveJailTime.sqf
Author: Kevin Webb
Description: The file name.
*/
private["_uid","_time"];
_uid = param [0,"",[""]];
_time = param [1];

_query = format["UPDATE players SET jailTime='%1' WHERE playerid='%2'",_time,_uid];

_queryResult = [_query,1] call DB_fnc_asyncCall;
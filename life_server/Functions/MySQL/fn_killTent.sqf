/*
	File: fn_killTent.sqf
	Author: Raku @ Veterans of Altis
	
	Kills the tent.
*/
private["_uid","_query"];
_uid = param [0,"",[""]];
if(_uid == "") exitWith {};
 
_query = format["UPDATE tents SET alive='0' WHERE pid='%1'",_uid];
[_query,1] call DB_fnc_asyncCall;
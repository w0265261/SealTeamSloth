/*
	File: fn_updateRequest.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Ain't got time to describe it, READ THE FILE NAME!
*/
private["_uid","_side","_cash","_bank","_licenses","_gear","_name","_query","_thread","_civPosition","_alive"];
_uid = param [0,"",[""]];
_name = param [1,"",[""]];
_side = param [2,sideUnknown,[civilian]];
_position = param [3,[],[[]]];
/*Get to those error checks.*/
if((_uid == "") OR (_name == "")) exitWith {};

/*Parse and setup some data.*/
_name = [_name] call DB_fnc_mresString;

switch (_side) do {
	case west: {_query = format["UPDATE players SET name='%1' WHERE playerid='%2'",_name,_uid];};
	case civilian: {_query = format["UPDATE players SET name='%1', civPosition='%2' WHERE playerid='%3'",_name,_position,_uid];};
	case independent: {_query = format["UPDATE players SET name='%1' WHERE playerid='%2'",_name,_uid];};
};

[_query,1] call DB_fnc_asyncCall;
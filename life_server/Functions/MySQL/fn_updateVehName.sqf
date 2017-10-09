/*
	File: fn_updateRequest.sqf
	Author: MrBoolean
	Based off of fn_updateRequest.sqf by Tonic
	
	Description:
	Ain't got time to describe it, READ THE FILE NAME!
*/
private["_uid","_side","_cash","_bank","_licenses","_gear","_name","_query","_thread","_civPosition","_alive"];
_vid = param [0,0];
_name = param [1,"",[""]];
/*Get to those error checks.*/
if((_vid == 0) OR (_name == "")) exitWith {};

/*Parse and setup some data.*/
_name = [_name] call DB_fnc_mresString;

_query = format["UPDATE vehicles SET customName='%1' WHERE id='%2'",_name,_vid];


_queryResult = [_query,1] call DB_fnc_asyncCall;
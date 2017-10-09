/*
(TON) fn_housePurchased.sqf
Kevin Webb
Handles house transfer of ownership, sort of.
*/
private["_uid","_pos","_car","_house","_query"];
_uid = param [0,"",[""]];
_pos = param [1,[],[[]]];
_car = param [2,false,[false]];
_house = param [3,ObjNull,[ObjNull]];
if(isNull _house) exitWith {};
if(_car) exitWith {

	_dbInfo = _house getVariable["dbInfo",[]];
	_Ouid = _dbInfo select 0;
	_plate = _dbInfo select 1;

	_query = format["UPDATE vehicles SET pid='%1' WHERE pid='%2' AND plate='%3'",_uid,_Ouid,_plate];

	
	[_query,1] call DB_fnc_asyncCall;
	_house setVariable["dbInfo",[_uid,_plate],true]
};
_query = format["UPDATE houses SET pid='%1', listPrice=0 WHERE pos='%2'",_uid,_pos];

[_query,1] call DB_fnc_asyncCall;
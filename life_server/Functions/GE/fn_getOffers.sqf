/*
	File: fn_getOffers.sqf
	Author: Kevin Webb
	
	Description:
	Sends a request to query the database information and returns active player offers.
	Copyright © 2015 Kevin Webb, All rights reserved
	Written for Seal Team Sloth ™ LLC
*/
private["_pid","_side","_type","_unit","_ret","_tickTime","_queryResult"];
_pid = param [0,"",[""]];
_unit = param [1,ObjNull,[ObjNull]];
_toCheck = param [2,false,[false]];


_query = "";
if(_toCheck) then {
	_buyorsell = param [3,0,[0]];
	_uid = param [4,"",[""]];
	if(_buyorsell > 1) then {
		_buyorsell = _buyorsell - 2;
		_query = format["SELECT ID, ClassName, Price, isVirtual, isWeapon, isVehicle, Amount, BuyorSell, VehicleID FROM Exchange WHERE active='1' AND BuyorSell='%2' AND NOT pid='%1'",_uid,_buyorsell];
	} else {
		_query = format["SELECT ID, ClassName, Price, isVirtual, isWeapon, isVehicle, Amount, BuyorSell, VehicleID FROM Exchange WHERE ClassName LIKE '%2%1%2' AND active='1' AND BuyorSell='%3' AND NOT pid='%4'",_pid,"%",_buyorsell,_uid];
	};
} else {
	_query = format["SELECT ID, ClassName, Price, isVirtual, isWeapon, isVehicle, Amount, BuyorSell, VehicleID FROM Exchange WHERE pid='%1' AND active='1'",_pid];
};
_queryResult = [_query,2,true] call DB_fnc_asyncCall; //param 3 means multi-array return format


if(typeName _queryResult == "STRING") exitWith {
	[[]] remoteExec ["life_fnc_GEMenu",_unit,false];
};

[_queryResult] remoteExec ["KBW_fnc_GEMenu",_unit,false];
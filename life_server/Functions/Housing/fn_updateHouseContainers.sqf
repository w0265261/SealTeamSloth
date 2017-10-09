/*
	BLAH BLAH
	I LOVE NOTEPAD++ GET OVER IT
	BLAH!
*/
private["_house","_houseID","_containers","_query"];
_house = param [0,ObjNull,[ObjNull]];
_locker = param [1,false,[false]];
if(_locker) exitWith {
	_uid = param [2,"",[""]];
	_arr = [getWeaponCargo _house,getMagazineCargo _house,getItemCargo _house,getBackpackCargo _house];
	_query = format["UPDATE players SET cop_locker='%1' WHERE playerid='%2'",_arr,_uid];

	[_query,1] call DB_fnc_asyncCall;
};
if(isNull _house) exitWith {};
_houseID = _house getVariable["house_id",-1];
if(_houseID == -1) exitWith {};
_inv = param [2,[],[[]]];

_query = format["UPDATE houses SET containers='%1' WHERE id='%2'",_inv,_houseID];

[_query,1] call DB_fnc_asyncCall;
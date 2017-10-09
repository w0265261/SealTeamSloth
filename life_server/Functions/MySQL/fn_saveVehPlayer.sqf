/*
fn_saveVehPlayer.sqf
Kevin Webb
Handles the saving of vehicle inventories in real time
*/
_vehicle = param [0,ObjNull,[ObjNull]];
_inv = param [1,false,[true]];
_pos = getPosATL _vehicle;
_uid = _vehicle getVariable "dbInfo" select 0;
_plate = _vehicle getVariable "dbInfo" select 1;
if(_inv) exitWith {
	_inventory = [getItemCargo _vehicle,getMagazineCargo _vehicle,getWeaponCargo _vehicle];
	_query = format["UPDATE vehicles SET inventory='%1',position='%2' WHERE pid='%3' AND plate='%4'",_inventory,_pos,_uid,_plate];
	[_query,1] call DB_fnc_asyncCall;
};
_virtItems = _vehicle getVariable ["Trunk",[]];
_query = format["UPDATE vehicles SET virtItems='%1',position='%2' WHERE pid='%3' AND plate='%4'",_virtItems,_pos,_uid,_plate];
[_query,1] call DB_fnc_asyncCall;
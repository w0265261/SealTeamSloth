/*
	File: fn_leaseMenu.sqf
	Author: Pennyworth
	
	Description:
	Initializes the lease menu
*/
private["_display","_vehicles","_plist","_near_units","_name"];
disableSerialization;

waitUntil {!isNull (findDisplay 2700)};
_display = findDisplay 2700;
_vehicles = _display displayCtrl 2701;
lbClear _vehicles;
_plist = _display displayCtrl 2702;
lbClear _plist;
_near_units = [];
_house = nearestBuilding (getPosATL player);
_leasers = _house getVariable["leasers",[]];

{ if(player distance _x < 20) then {_near_units pushBack _x;};} foreach playableUnits;

{
	_name = _x select 1;
	
	_vehicles lbAdd format["%1",_name];
	_vehicles lbSetData [(lbSize _vehicles)-1,str(_forEachIndex)];
} forEach _leasers;

{
	if(!isNull _x && alive _x && player distance _x < 20 && _x != player) then
	{
		_plist lbAdd format["%1 - %2",_x getVariable["realname",name _x], side _x];
		_plist lbSetData [(lbSize _plist)-1,str(_x)];
	};
} foreach _near_units;

if(((lbSize _vehicles)-1) == -1) then
{
	_vehicles lbAdd "There are no leasers";
	_vehicles lbSetData [(lbSize _vehicles)-1,str(ObjNull)];
};
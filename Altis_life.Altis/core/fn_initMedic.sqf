#include <macro.h>
/*
	File: fn_initMedic.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes the medic..
*/
private["_end"];
player addRating 99999999;
waitUntil {!(isNull (findDisplay 46))};

if((__GETC__(life_medicLevel)) < 1 && (__GETC__(style)) < 1 && !(str player in["medic_2","medic_3","medic_4"])) exitWith {
	["Notwhitelisted",FALSE,TRUE] call BIS_fnc_endMission;
};

[] call life_fnc_medicLoadGear;
[] call life_fnc_spawnMenu;
waitUntil{!isNull (findDisplay 38500)}; /*Wait for the spawn selection to be open.*/
waitUntil{isNull (findDisplay 38500)}; /*Wait for the spawn selection to be done.*/

[] call life_fnc_equipGear;
[] spawn {
	sleep 3;
	{
		if(_x getVariable["medic",false]) then {
		if(_x getVariable["trackee",""] == getPlayerUID player) then {[_x,true] spawn life_fnc_gpsTracker};
		_dbInfo = _x getVariable["dbInfo",[]];
		if(count _dbInfo > 0) then {
			_vehicle = _x;
			if(_dbInfo select 0 == getPlayerUID player) exitWith {life_vehicles pushBack _x};
			{if(getPlayerUID player == (_x select 0)) exitWith {life_vehicles pushBack _vehicle};} forEach (_vehicle getVariable "vehicle_info_owners");
		};
		};
	} forEach vehicles;
};
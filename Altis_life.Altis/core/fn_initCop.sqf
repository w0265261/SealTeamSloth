#include <macro.h>
/*
	File: fn_initCop.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Cop Initialization file.
*/
private["_end"];
player addRating 9999999;
waitUntil {!(isNull (findDisplay 46))};
_end = false;
if(life_blacklisted) exitWith
{
	["Blacklisted",false,true] call BIS_fnc_endMission;
};

if(!(str(player) in ["cop_28","cop_27","cop_26","cop_31"])) then {
    if(__GETC__(life_coplevel) == 0) then {
        ["NotWhitelisted",false,true] call BIS_fnc_endMission;
        sleep 35;
    };
};

if(__GETC__(life_coplevel) < 3 && undercover) exitWith {
	["NotWhitelisted",false,true] call BIS_fnc_endMission;
};

if(__GETC__(life_coplevel) < 5 && missionNamespace getVariable["UAV_1",ObjNull] == player) exitWith {
	["NotWhitelisted",false,true] call BIS_fnc_endMission;
};

player setVariable["rank",(__GETC__(life_coplevel)),true];
(group player) setBehaviour "STEALTH";
[] call life_fnc_spawnMenu;
waitUntil{!isNull (findDisplay 38500)}; /*Wait for the spawn selection to be open.*/
waitUntil{isNull (findDisplay 38500)}; /*Wait for the spawn selection to be done.*/

[] call life_fnc_equipGear;
[] spawn {
sleep 2.5;
if(undercover) then {
	createDialog "STS_KBW_price_diag";
	waitUntil{!isNull (findDisplay 13371)};
	ctrlSetText[2651,"Type your undercover name"];
	waitUntil{isNull (findDisplay 13371) || life_charged};
	if(!(life_charged)) exitWith {};
	life_charged = false;
	_name = ctrlText 7331;
	player setVariable["realname",_name,true];
	life_realname = _name;
	player setVariable["undercover",true,true];
	closeDialog 0;
};
};
[] spawn {
	sleep 3;
	{
		if(_x getVariable["copCar",false]) then {
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
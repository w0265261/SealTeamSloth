#include <macro.h>
/*
	File: fn_initCiv.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Initializes the civilian.
*/
private["_spawnPos","_msg","_msg2"];
_msg = format["Hack Alert %1 has been flagged for having suspicious money. He has %2 cash in bank with no moneymaking licenses.",profileName,life_myfunds];
_msg2 = "Hack Alert the player with the above name has an unobtainable license, he is possibly using a hack which gives himself all of the licenses.";
civ_spawn_1 = nearestObjects[getMarkerPos  "civ_spawn_1", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
civ_spawn_2 = nearestObjects[getMarkerPos  "civ_spawn_2", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
civ_spawn_3 = nearestObjects[getMarkerPos  "civ_spawn_3", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
civ_spawn_4 = nearestObjects[getMarkerPos  "civ_spawn_4", ["Land_i_Shop_01_V1_F","Land_i_Shop_02_V1_F","Land_i_Shop_03_V1_F","Land_i_Stone_HouseBig_V1_F"],250];
waitUntil {!(isNull (findDisplay 46))};
if(life_is_alive && !life_is_arrested) then {
player setPosATL civ_position;
}
else 
{
if (!life_is_alive && !life_is_arrested) then
{
	[] call life_fnc_spawnMenu;
	waitUntil{!isNull (findDisplay 38500)}; /*Wait for the spawn selection to be open.*/
	waitUntil{isNull (findDisplay 38500)}; /*Wait for the spawn selection to be done.*/
}	
else 
{
	if(life_is_arrested) then
	{
		life_is_arrested = false;
		[player,true,jail_time] spawn life_fnc_jail;
	};
}; 
};
player addRating 9999999;

[] call life_fnc_initHouses;

if(license_civ_bh) then {
	player setVariable ["bountyHunter", true, true];
};
if(__GETC__(style) == 0) then {
if(life_myfunds > 90000 && !(license_civ_delivery || license_civ_excav || license_civ_logging || license_civ_steel || license_civ_gold || license_civ_moonshine || license_civ_cement || license_civ_salt || license_civ_sand || license_civ_iron || license_civ_copper || license_civ_diamond || license_civ_coke ||
license_civ_oil || license_civ_marijuana || license_civ_heroin || license_civ_meth)) then {
[3,-1,_msg] call life_fnc_newMsg;
hintSilent "";
};
};
if(license_civ_hacker) then {[3,-1,_msg2] call life_fnc_newMsg;};
[] spawn {
	sleep 3;
	{
		if(!(_x getVariable["copCar",false]) && !(_x getVariable["medic",false])) then {
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
if(count life_mailbox > 0) then {systemChat "It seems there are items in your AE mailbox!"};
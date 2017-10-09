#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Used for syncing house container data but when the inventory menu
	is closed a sync request is sent off to the server.
*/
private["_container","_gear"];
_container = param [1,ObjNull,[ObjNull]];
if(isNull _container) exitWith {};
[] call life_fnc_saveThat;
if(count (_container getVariable["dbInfo",[]]) > 0) exitWith {
	[_container,true] remoteExec ["DB_fnc_saveVehPlayer",2];
};

if((typeOf _container) == "O_supplyCrate_F" && _container getVariable["owner",""] == getPlayerUID player) exitWith {
	[_container,true,getPlayerUID player] remoteExec ["TON_fnc_updateHouseContainers",2];
};
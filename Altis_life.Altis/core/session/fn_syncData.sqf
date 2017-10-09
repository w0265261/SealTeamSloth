/*
	File: fn_syncData.sqf
	Author: Bryan "Tonic" Boardwine"
	
	Description:
	Used for player manual sync to the server.
*/
if(life_paintballing) exitWith {};
if(isNil "life_session_time") then {life_session_time = false;};
if(life_session_time) exitWith {hint localize "STR_Session_SyncdAlready";};
if(life_respawning) exitWith {};
[] call life_fnc_equipGear;
[] call life_fnc_hudUpdate;

[] call SOCK_fnc_updateRequest;
hint localize "STR_Session_SyncData";
[] spawn
{
	life_session_time = true;
	sleep (5 * 60);
	life_session_time = false;
};
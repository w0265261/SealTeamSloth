/*
	File: fn_killTent.sqf
	Author: Raku @ Veterans of Altis
	
	Kills the tent in the backend.
*/
life_tent = [];
[getPlayerUID player] remoteExec ["DB_fnc_killTent",2];
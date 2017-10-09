/*
    File: fn_savePlayerBounties.sqf
	Author: Kevin Webb
	Description: Saves the players wanted charges for that specific player.
*/
private["_uid","_crimes"];
_uid = param [1,"",[""]];
_crimes = param [0,[],[[]]];
_query = format["UPDATE players SET bounties='%1' WHERE playerid='%2'",_crimes,_uid];	

[_query,1] call DB_fnc_asyncCall;
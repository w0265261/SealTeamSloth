/*
    file: fn_loadBounties.sqf
	Author: Kevin Webb
	Description: Adds the player to the wanted list when they join the server if they were wanted.
*/
private["_uid"];
_uid = param [0,"",[""]];
_name = param [1,"",[""]];
_unit = param [2,ObjNull,[ObjNull]];

_query = format["SELECT bounties FROM players WHERE playerid = '%1'",_uid];	

_queryResult = [_query,2] call DB_fnc_asyncCall;
_queryResult = _queryResult select 0;
if(count _queryResult == 0) exitWith {};
_queryResult set[0,_name];
life_wanted_list pushBack _queryResult;
publicVariable "life_wanted_list";
[true] remoteExec ["life_fnc_amIWanted",_unit,false];
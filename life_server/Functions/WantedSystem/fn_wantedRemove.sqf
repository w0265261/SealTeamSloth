/*
	File: fn_wantedRemove.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Removes a person from the wanted list.
*/
private["_uid","_index","_check"];
_uid = param [0,"",[""]];
_check = param [1,0,[0]];
if(_uid == "") exitWith {}; /*Bad data*/

_index = [_uid,life_wanted_list] call fnc_index;
if(_index == -1) exitWith {};
life_wanted_list set[_index,-1];
life_wanted_list = life_wanted_list - [-1];
publicVariable "life_wanted_list";
if(_check != 0) exitWith {};
[[],_uid] spawn TON_fnc_saveBounties;
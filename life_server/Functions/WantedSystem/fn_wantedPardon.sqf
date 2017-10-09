/*
	File: fn_wantedPardon.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Unwants / pardons a person from the wanted list.
*/
private["_uid"];
_uid = param [0,"",[""]];
_player = param[1,objNull];
if(_uid == "") exitWith {};

_index = [_uid,life_wanted_list] call fnc_index;

if(_index != -1) then
{
	life_wanted_list set[_index,-1];
	life_wanted_list = life_wanted_list - [-1];
	publicVariable "life_wanted_list";
	[[],_uid] spawn TON_fnc_saveBounties;
};
if(_player getVariable["governor",false]) then {governorPardon = true; publicVariable "governorPardon"};
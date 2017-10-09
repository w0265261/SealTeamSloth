/*
	File: fn_civDefault.sqf
	Author: Kevin Webb
	
	Description:
	Default civ configuration.
*/
/*Strip the player down*/
RemoveAllWeapons player;
{player removeMagazine _x;} foreach (magazines player);
removeUniform player;
removeVest player;
removeBackpack player;
removeGoggles player;
removeHeadGear player;
{
	player unassignItem _x;
	player removeItem _x;
} foreach (assignedItems player);


_uniform = [];
{_uniform pushBack (_x select 0); if(_forEachIndex == 19) exitWith {}} forEach ([0,false] call life_fnc_clothing_bruce);
_uniform = _uniform call BIS_fnc_selectRandom;

_hat = [];
{_hat pushBack (_x select 0); if(_forEachIndex == 31) exitWith {}} forEach ([1,false] call life_fnc_clothing_bruce);
_hat = _hat call BIS_fnc_selectRandom;

_glasses = [];
{_glasses pushBack (_x select 0)} forEach ([2,false] call life_fnc_clothing_bruce);
_glasses = _glasses call BIS_fnc_selectRandom;

player addUniform _uniform;
player addHeadGear _hat;
player addGoggles _glasses;


player addItem "ItemMap";
player assignItem "ItemMap";
player addItem "ItemRadio";
player assignItem "ItemRadio";
player addItem "ItemCompass";
player assignItem "ItemCompass";
player addItem "ItemWatch";
player assignItem "ItemWatch";

[] call life_fnc_saveThat;
[] call life_fnc_equipGear;
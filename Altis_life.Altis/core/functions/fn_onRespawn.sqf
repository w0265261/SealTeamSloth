#include <macro.h>
/*
	File: fn_onRespawn.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Execute various actions when the _unit respawns.
*/
private["_unit","_corpse"];
_unit = param [0,objNull,[objNull]];
_corpse = param [1,objNull,[objNull]];
life_corpse = _corpse;
if(isNull _unit) exitWith {};
/*Cleanup of weapon containers near the body & hide it.*/
if(!isNull life_corpse) then {
	private["_containers"];
	_containers = nearestObjects[life_corpse,["WeaponHolderSimulated"],5];
	{deleteVehicle _x;} foreach _containers; /*Delete the containers.*/
	deleteVehicle life_corpse;
};


life_abort_enabled = false;
_unit enableFatigue false;


_name = if(undercover || life_realname != "") then {life_realname} else {profileName};
_unit setVariable["realname",_name,true]; /*Reset the players name.*/

switch(playerSide) do
{
	case west:
	{
		[] spawn life_fnc_copDefault;
	};

	case civilian:
	{
		[] spawn life_fnc_civDefault;
	};

	case independent:
	{
		[] call life_fnc_medicLoadGear;
		[] call life_fnc_equipGear;

	};
};
{player setVariable[_x,false]} forEach ["mm","acp","rifle","heavy","sniper","fucked"];
if(life_is_arrested) then
{
	hintC "Not very smart! You tried to suicide from jail, you will be jailed again with your time reset!";
	life_is_arrested = false;
	[_unit,true,jail_time] spawn life_fnc_jail;
}
	else
{
	titleText["","BLACK FADED"];
	titleFadeOut 9999999999;
	[] call life_fnc_spawnMenu;
	waitUntil{!isNull (findDisplay 38500)}; /*Wait for the spawn selection to be open.*/
	waitUntil{isNull (findDisplay 38500)}; /*Wait for the spawn selection to be done..*/
};

if(playerSide == west) then {
	private["_getRank"];
	_getRank = call life_coplevel;
	player setVariable["coplevel",_getRank,true];
};

_unit addRating 100000;
_side = if(playerSide in[independent,west] && !undercover) then {west} else {civilian};
[_unit,life_sidechat,_side] remoteExec ["TON_fnc_managesc",2];
[] call life_fnc_hudUpdate;
cutText ["","BLACK IN"];


if(life_governor) then {player setVariable["governor",true,true]};
if(license_civ_bh) then {
	player setVariable ["bountyHunter", true, true];
};
if(playerSide == civilian) then {
	[] call SOCK_fnc_updateRequest;
};
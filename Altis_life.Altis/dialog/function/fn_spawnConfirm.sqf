/*
	File: fn_spawnConfirm.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Spawns the player where he selected.
*/
private["_spCfg","_sp","_spawnPos","_handle"];
if(life_lastKnownPos distance (getMarkerPos (life_spawn_point select 0)) < 1000) exitWith {systemChat "You cannot spawn there, as it is too close to the scene of your death. Choose another spawn."; };

closeDialog 0;
cutText ["","BLACK IN"];
if(count life_spawn_point == 0) then
{
	private["_sp","_spCfg"];
	_spCfg = [playerSide] call life_fnc_spawnPointCfg;
	_sp = _spCfg select 0;
	
	if(playerSide == civilian) then
	{
		if(isNil {(call compile format["%1", _sp select 0])}) then {
			player setPos (getMarkerPos (_sp select 0));
		} else {
			_spawnPos = (call compile format["%1", _sp select 0]) call BIS_fnc_selectRandom;
			_spawnPos = _spawnPos buildingPos 0;
			player setPos _spawnPos;
		};
	}
		else
	{
		player setPos (getMarkerPos (_sp select 0));
	};
	titleText[format["%2 %1",_sp select 1,localize "STR_Spawn_Spawned"],"BLACK IN"];
}
	else
{
	if(playerSide == civilian) then
	{
		if(isNil {(call compile format["%1",life_spawn_point select 0])}) then {
			if((["house",life_spawn_point select 0] call BIS_fnc_inString)) then {
				private["_bPos","_house","_pos"];
				_house = nearestObjects [getMarkerPos (life_spawn_point select 0),["House_F"],10] select 0;
				_bPos = [_house] call life_fnc_getBuildingPositions;

				if(count _bPos == 0) exitWith {
					player setPos (getMarkerPos (life_spawn_point select 0));
				};

				_pos = _bPos call BIS_fnc_selectRandom;
				player setPosATL _pos;
			} else {
				player setPos (getMarkerPos (life_spawn_point select 0));
			};
		} else {
			_spawnPos = (call compile format["%1", life_spawn_point select 0]) call BIS_fnc_selectRandom;
			_spawnPos = _spawnPos buildingPos 0;
			player setPos _spawnPos;
		};
	}
		else
	{
		player setPos (getMarkerPos (life_spawn_point select 0));
	};
	titleText[format["%2 %1",life_spawn_point select 1,localize "STR_Spawn_Spawned"],"BLACK IN"];
};
if(life_spawn_point select 1 == "Tent") then {
	[] call SOCK_fnc_killTent;
	deleteMarkerLocal format["civ_spawn_tent_%1",getPlayerUID player];
};
/*Introcam*/
_handle = [] spawn life_fnc_IntroCam;

if(life_firstSpawn) then {
	life_firstSpawn = false;
} else {
	if(playerSide != west) exitWith {};
	_price = if((life_gear select 6) in ownedWeapons) then {1000} else {
		_index = [(life_gear select 6),life_weapon_shop_array] call fnc_index;
		if(_index == -1) exitWith {-1};
		_temp = (life_weapon_shop_array select _index) select 1;
		_temp = _temp * 0.85;
		_temp;
	};
	if(_price == -1) exitWith {};
	if(life_myfunds > _price) then {
		[_handle,_price] spawn {
			waitUntil{scriptDone (_this select 0)};
			_action = [
			format["Would you like to repurchase all of the gear you just died with, including Y menu items, for a price of $%1?",_this select 1],
			"Buy old gear",
			localize "STR_Global_Yes",
			localize "STR_Global_No"
			] call BIS_fnc_guiMessage;
			if(_action) then {
				hint "You have been outfitted with all of your old gear";
				[false] call life_fnc_optiloadGear;
				["atm","take",_this select 1] call life_fnc_handlePaper;
			};
		};
	};
};
[] call life_fnc_hudSetup;
life_respawning = false;
if(playerSide == civilian) then {
life_is_alive = true;
[8] call SOCK_fnc_updatePartial;
};
#include <macro.h>
/*
	File: fn_vehicleShopMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Blah
*/
private["_shop","_sideCheck","_spawnPoints","_shopFlag","_disableBuy"];
_shop = [(_this select 3),0,"",[""]] call BIS_fnc_param;
_sideCheck = [(_this select 3),1,sideUnknown,[civilian]] call BIS_fnc_param;
_spawnPoints = [(_this select 3),2,"",["",[]]] call BIS_fnc_param;
_shopFlag = [(_this select 3),3,"",[""]] call BIS_fnc_param;
_disableBuy = [(_this select 3),5,false,[true]] call BIS_fnc_param;

disableSerialization;
/*Long boring series of checks*/
if(dialog) exitWith {};
if(_shop == "") exitWith {};
if(_sideCheck != sideUnknown && {playerSide != _sideCheck}) exitWith {hint localize "STR_Shop_Veh_NotAllowed"};

if(!createDialog "STS_Life_Vehicle_Shop_v2") exitWith {};

if(playerSide == west) then {
if(undercover && _shop == "cop_car") then {_shop = "civ_car"};
if(undercover && _shop == "cop_air") then {_shop = "civ_air"};
if(undercover && _shop == "cop_ship") then {_shop = "civ_ship"};
};

life_veh_shop = [_shop,_spawnpoints,_shopFlag,_disableBuy];
_str = if(life_veh_shop select 0 in["reb_air","reb_car"]) then {""} else {"; Tax: %1%2"};
ctrlSetText [2301,((_this select 3) select 4) + format[_str,(life_rules select 1) / 2,"%"]];

if(_disableBuy) then {
	ctrlEnable [2309,false];
};

_vehicleList = [_shop] call life_fnc_vehicleListCfg;

_control = ((findDisplay 2300) displayCtrl 2302);
lbClear _control; /*Flush the list.*/
ctrlShow [2330,false];
ctrlShow [2304,false];

/*Loop through*/
{
	_className = _x select 0;
	_vehicleInfo = [_className] call life_fnc_fetchVehInfo;
	_control lbAdd (_vehicleInfo select 3);
	_control lbSetPicture [(lbSize _control)-1,(_vehicleInfo select 2)];
	_control lbSetData [(lbSize _control)-1,_className];
	_control lbSetValue [(lbSize _control)-1,_ForEachIndex];
} foreach _vehicleList;
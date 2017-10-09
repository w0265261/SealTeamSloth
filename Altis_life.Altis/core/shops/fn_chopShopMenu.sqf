#include <macro.h>
/*
	File: fn_chopShopMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Opens & initializes the chop shop menu.
*/
if(life_action_inUse) exitWith {hint localize "STR_NOTF_ActionInProc"};
disableSerialization;
private["_nearVehicles","_control"];
_nearVehicles = nearestObjects [getMarkerPos (_this select 3),["Car","Truck","Ship","C_supplyCrate_F"],25];

life_chopShop = (_this select 3);
/*Error check*/
if(count _nearVehicles == 0) exitWith {titleText[localize "STR_Shop_NoVehNear","PLAIN"];};
if(!(createDialog "STS_Chop_Shop")) exitWith {hint localize "STR_Shop_ChopShopError"};

_control = ((findDisplay 39400) displayCtrl 39402);
{
	if(alive _x) then {
		_className = typeOf _x;
		_displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
		_picture = getText(configFile >> "CfgVehicles" >> _className >> "picture");
		_ind = [_className,life_vehicle_buy] call fnc_index;
		
		if((_ind != -1 && count crew _x == 0) || (_className == "C_supplyCrate_F" && _x != life_DPBox)) then {
			_price = if(_className == "C_supplyCrate_F") then {_x getVariable["value",0]} else {(((life_vehicle_buy select _ind) select 1) / 2)};
			_control lbAdd _displayName;
			_control lbSetData [(lbSize _control)-1,str(_forEachIndex)];
			if(_className != "C_supplyCrate_F") then {_control lbSetPicture [(lbSize _control)-1,_picture]};
			_control lbSetValue [(lbSize _control)-1,_price];
		};
	};
} foreach _nearVehicles;
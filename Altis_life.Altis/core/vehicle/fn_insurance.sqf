#include <macro.h>
/*
Filename: fn_insurance.sqf
Author: Kevin Webb
Description: Simple way of insuring the vehicle. Will be modified in the future.
*/
_isPerm = _this;
private["_nearVehicles","_vehicle","_price","_veh_name"];
if(!isNull objectParent player) then
{
	_vehicle = vehicle player;
}
	else
{
	_nearVehicles = nearestObjects[getPos player,["Car","Air","Ship"],50];
	if(count _nearVehicles > 0) then
	{
		{
			if(!isNil "_vehicle") exitWith {}; /*Kill the loop.*/
			_vehData = _x getVariable["vehicle_info_owners",[]];
			if(count _vehData  > 0) then
			{
				_vehOwner = (_vehData select 0) select 0;
				if((getPlayerUID player) == _vehOwner) exitWith
				{
					_vehicle = _x;
				};
			};
		} foreach _nearVehicles;
	};
};

if(isNil "_vehicle") exitWith {hint "Make sure your vehicle is closest to the NPC and try again";};
if(isNull _vehicle) exitWith {};
if(_vehicle getVariable["isInsured",false]) exitWith { hint "This vehicle already has insurance."; };
if(!(_vehicle in life_vehicles)) exitWith {hint "The target vehicle doesn't seem to be your own."; };
_price = [typeOf _vehicle,life_vehicle_buy] call fnc_index;
if(_price == -1) exitWith { hint "You can not insure this type of vehicle. If you feel that this is an error, report it to a developer."; };
_price = ((life_vehicle_buy select _price) select 1) / 20;
if(_isPerm) then {_price = _price * 10};
if(playerSide == independent) then { _price = _price / 4; };
//if(playerSide == west) then { _price = _price / 2; };
_price = (_price * __GETC__(life_vip_discount));
if(life_myfunds < _price) exitWith { hint format["You do not have enough money in your bank account to complete this transaction, it requires $%1",_price]; };
_veh_name = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
closeDialog 0;
_action = [
format["Are you sure you want to insure your %1 for $%2?",_veh_name,[_price] call life_fnc_numberText],
"Buying vehicle insurance.",
localize "STR_Global_Yes",
localize "STR_Global_No"
] call BIS_fnc_guiMessage;
_str = if(_isPerm) then {"This insurance will remain active until this vehicle is destroyed. It also comes with a GPS tracker which lasts for the duration of the insurance."} else {"This insurance is only active during this session."};
if(_action) then {
	hint format["You have been charged $%1 to insure this vehicle. If it explodes, it will be placed back inside your garage. " + _str,_price];
	["atm","take",_price] call life_fnc_handlePaper;
	closeDialog 0;
	if(_isPerm) then {
		[_vehicle,true,player] remoteExec ["TON_fnc_vehicleInsurance",2];
	} else {
		[_vehicle] remoteExec ["TON_fnc_vehicleInsurance",2];
	};
};
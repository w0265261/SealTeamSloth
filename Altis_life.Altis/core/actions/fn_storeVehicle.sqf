/*
	File: fn_storeVehicle.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Stores the vehicle in the garage.
*/
private["_nearVehicles","_vehicle"];
if(!isNull objectParent player) then
{
	_vehicle = vehicle player;
}
	else
{
	_nearVehicles = nearestObjects[getPos (_this select 0),["Car","Air","Ship","Land_Pod_Heli_Transport_04_covered_F","Land_Pod_Heli_Transport_04_bench_F"],30]; /*Fetch vehicles within 30m.*/
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

if(isNil "_vehicle") exitWith {hint "Make sure your vehicle is closest to the NPC and try again"};
if(isNull _vehicle) exitWith {};

_vehItem = getItemCargo _vehicle;
_vehWeapon = getWeaponCargo _vehicle;
_vehAmmo = getMagazineCargo _vehicle;
_vehBackpack = getBackpackCargo _vehicle;
_countWeapons1 = count (_vehWeapon select 0);
_countAmmo1 = count (_vehAmmo select 0);
_allowedItems = ["ToolKit","FirstAidKit"];
_exit = false;
{if(!(_x in _alloweditems)) exitWith {_exit = true}} forEach (_vehItem select 0);

if(_countWeapons1 != 0 || _countAmmo1 != 0 || (_vehicle getVariable["Trunk",[[],0]]) select 1 > 0) then {_exit = true};

{if(!(["Parachute",_x] call BIS_fnc_inString)) exitWith {_exit = true}} forEach (_vehBackpack select 0);

if(_exit) exitWith {
	_vehicle spawn {
		_action = ["It appears you have some items in the physical vehicle cargo which will be removed upon storing. Continue anyway?","Cargo Alert","Yes","No"] call BIS_fnc_GUIMessage;
		if(_action) then {
			[_this,false,player] remoteExec ["TON_fnc_vehicleStore",2];
			life_garage_store = true;
		};
	};

};

[_vehicle,false,player] remoteExec ["TON_fnc_vehicleStore",2];
life_garage_store = true;
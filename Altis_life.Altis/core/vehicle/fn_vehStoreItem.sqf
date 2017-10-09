#define ctrlSelData(ctrl) (lbData[##ctrl,(lbCurSel ##ctrl)])
/*
	File: fn_vehStoreItem.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Used in the vehicle trunk menu, stores the selected item and puts it in the vehicles virtual inventory
	if the vehicle has room for the item.
*/
private["_ctrl","_num","_totalWeight","_itemWeight","_veh_data","_inv","_index","_val","_veh","_unit"];
disableSerialization;
_unit = vehicle player;
_veh = typeOf _unit;
_ctrl = ctrlSelData(3503);
_num = ctrlText 3506;
if(!([_num] call fnc_isnumber)) exitWith {hint "Invalid Number format";};
_num = parseNumber(_num);
if(_num < 1) exitWith {hint "You can't enter anything below 1!";};
if(life_trunk_vehicle getVariable["loaded",false]) exitWith {hint "You cannot store items in a vehicle which is loaded onto another"; };

if(life_trunk_vehicle isKindOf "House_F") then {
	_mWeight = 500;
	//{_mWeight = _mWeight + ([(typeOf _x)] call life_fnc_vehicleWeightCfg);} foreach (life_trunk_vehicle getVariable["containers",[]]);
	_totalWeight = [_mWeight,(life_trunk_vehicle getVariable["Trunk",[[],0]]) select 1];
} else {
	_totalWeight = [life_trunk_vehicle] call life_fnc_vehicleWeight;
};
_itemWeight = ([_ctrl] call life_fnc_itemWeight) * _num;
_veh_data = life_trunk_vehicle getVariable ["Trunk",[[],0]];
_inv = _veh_data select 0;

if(_ctrl in["eph","meth","phos","hydro","goldbar"] && {!(life_trunk_vehicle isKindOf "LandVehicle" OR life_trunk_vehicle isKindOf "Ship" OR life_trunk_vehicle isKindOf "House_F" OR typeOf life_trunk_vehicle == "Land_i_Shed_Ind_F")}) exitWith {hint "The nature of this item prevents it from being stored in a helicopter!"};
if(_ctrl in["oilu","oilp"] && !(_veh in["O_Truck_03_fuel_F","B_Truck_01_fuel_F","C_Van_01_fuel_F","O_SDV_01_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_F","C_Rubberboat"]) && !(life_trunk_vehicle isKindOf "House_F")) exitWith {hint "To store oil, you must be inside of an oil tanker type of vehicle";};
if(_ctrl in ["heroinp","heroinu","cocainep","cocaine","cannabis","eph","meth","phos","hydro","marijuana","moonshine"]) then {life_trunk_vehicle setVariable["drugRunner",true,true];};


	if(((_totalWeight select 1) + _itemWeight) > (_totalWeight select 0)) exitWith {hint "The vehicle is either full or cannot hold that much."};

	if(!([false,_ctrl,_num] call life_fnc_handleInv)) exitWith {hint "Couldn't remove the items from your inventory to put in the vehicle.";};
	_index = [_ctrl,_inv] call fnc_index;
	if(_index == -1) then
	{
		_inv pushBack [_ctrl,_num];
	}
		else
	{
		_val = _inv select _index select 1;
		_inv set[_index,[_ctrl,_val + _num]];
	};
	
	life_trunk_vehicle setVariable["Trunk",[_inv,(_veh_data select 1) + _itemWeight],true];
	[life_trunk_vehicle] call life_fnc_vehInventory;
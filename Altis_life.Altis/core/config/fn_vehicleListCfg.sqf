#include <macro.h>
/*
	File:
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration list / array for buyable vehicles & prices and their shop.
*/
private["_shop","_return"];
_shop = param [0,"",[""]];
if(_shop == "") exitWith {[]};
_return = [];
switch (_shop) do
{
	case "med_shop":
	{
		_return = [
			["C_SUV_01_F"],
			["C_Hatchback_01_F"],
			["C_Offroad_01_F"],
			["C_Offroad_01_repair_F"],
			["C_Hatchback_01_sport_F"]
		];
	};
	
	case "med_air": {
		_return = [
			["O_Heli_Light_02_unarmed_F"],
			["B_Heli_Light_01_F"],
			["C_Heli_Light_01_civil_F"],
			["O_Heli_Transport_04_medevac_F"]
		];
	};
	
	case "civ_car":
	{
		_return = 
		[
			["B_Quadbike_01_F"],
			["C_Hatchback_01_F"],
			["C_Offroad_01_F"],
			["C_SUV_01_F"],
			["C_Hatchback_01_sport_F"],
			["C_Kart_01_F"]
		];
	};
	
	case "civ_truck":
	{
		_return =
		[
			["C_Offroad_01_repair_F"],
			["C_Van_01_transport_F"],
			["C_Van_01_box_F"],
			["C_Van_01_fuel_F"],
			["I_Truck_02_transport_F"],
			["I_Truck_02_covered_F"],
			["I_Truck_02_fuel_F"],
			["O_Truck_03_transport_F"],
			["O_Truck_03_covered_F"],
			["O_Truck_03_fuel_F"],
			["O_Truck_03_device_F"],
			["B_Truck_01_mover_F"],	
			["B_Truck_01_transport_F"],
			["B_Truck_01_covered_F"],
			["B_Truck_01_fuel_F"],
			["B_Truck_01_box_F"]		
		];	
	};
	
	
	case "reb_car":
	{
		_return =
		[
			["B_Quadbike_01_F"],
			["I_G_Offroad_01_F"],
			["O_MRAP_02_F"],
			["I_MRAP_03_F"]
		];
		_toSelect = ((life_capture_list) select 0);
		if(_toSelect select 2 == 1 && _toSelect select 0 == group player getVariable["gang_name",""]) then {
			_return pushBack ["I_G_Offroad_01_armed_F"]
		};
	};

	case "reb_air":
	{
		_return =
		[
			["B_Heli_Light_01_F"],
			["O_Heli_Light_02_unarmed_F"],
			["I_Heli_Transport_02_F"],
			["O_Heli_Transport_04_F"],
			["O_Heli_Transport_04_covered_F"],
			["O_Heli_Transport_04_bench_F"],
			["O_Heli_Transport_04_box_F"],
			["Land_Pod_Heli_Transport_04_bench_F"]
			/*["O_Heli_Transport_04_ammo_F",950000],
			["O_Heli_Transport_04_repair_F",950000],
			["O_Heli_Transport_04_fuel_F",950000]*/
			
		];
	};
	
	case "cop_car":
	{
		_return =
		[
			["B_Quadbike_01_F"],
			["C_Hatchback_01_F"]
		];

		if(__GETC__(life_coplevel) > 0) then
		{
			_return pushBack
			["C_Offroad_01_F"];
			_return pushBack
			["C_SUV_01_F"];
		};

		if(__GETC__(life_coplevel) > 2) then
		{
			_return pushBack
			["C_Hatchback_01_sport_F"];
		};
		
		if(__GETC__(life_coplevel) > 3) then
		{
			_return pushBack
			["B_MRAP_01_F"];
		};
	};
	
	case "civ_air":
	{
		_return =
		[
			["C_Heli_Light_01_civil_F"],
			["B_Heli_Light_01_F"],
			["O_Heli_Light_02_unarmed_F"],
			["I_Heli_Transport_02_F"],
			["B_Heli_Transport_03_unarmed_F"],
			["Land_Pod_Heli_Transport_04_bench_F"]
		];
	};
	
	case "cop_air":
	{
		if(__GETC__(life_coplevel) > 1) then
		{
			_return pushBack
			["C_Heli_Light_01_civil_F"];
		};
		
		if(__GETC__(life_coplevel) > 2) then
		{
			_return pushBack
			["I_Heli_light_03_unarmed_F"];
			_return pushBack
			["Land_Pod_Heli_Transport_04_bench_F"];
			_return pushBack
			["Land_Pod_Heli_Transport_04_covered_F"];
			_return pushBack
			["B_Heli_Light_01_F"];
		};

		if(__GETC__(life_coplevel) > 3) then
		{	
			_return pushBack ["B_Heli_Transport_03_unarmed_F"];
		};

		if(__GETC__(life_coplevel) > 4) then
		{
			_return pushBack
			["B_Heli_Transport_01_F"];
			_return pushBack
			["B_Heli_Transport_03_F"];
			_return pushBack
			["B_Heli_Transport_03_black_F"];
		};

		if(__GETC__(life_coplevel) > 5) then
		{
		};
	};
	
	case "civ_ship":
	{
		_return =
		[
			["C_Rubberboat"],
			["C_Boat_Civil_01_F"],
			["C_Boat_Civil_01_rescue_F"],
			["O_SDV_01_F"]
		];
	};

	case "cop_ship":
	{
		
		_return pushBack
		["B_Boat_Transport_01_F"];
		if(__GETC__(life_coplevel) > 1) then
		{
			_return pushBack
			["C_Boat_Civil_01_police_F"];
		};
		if(__GETC__(life_coplevel) > 2) then
		{
			_return pushBack
			["B_SDV_01_F"];
		};
		if(__GETC__(life_coplevel) > 3) then
		{
			_return pushBack
			["B_Boat_Armed_01_minigun_F"];
		};
		
	};
};

_return;

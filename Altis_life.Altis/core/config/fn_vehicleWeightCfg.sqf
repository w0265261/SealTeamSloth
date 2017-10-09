/*
	File: fn_vehicleWeightCfg.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration for vehicle weight.
*/
private["_className"];
_className = param [0,"",[""]];

switch (_className) do
{
	case "C_Offroad_01_F": {70};
	case "C_Offroad_01_repair_F": {60};
	case "B_G_Offroad_01_F": {70};
	case "B_Quadbike_01_F": {25};
	case "I_Truck_02_covered_F": {250};
	case "I_Truck_02_transport_F": {250};
	case "I_Truck_02_fuel_F": {220};
	case "C_Hatchback_01_F": {40};
	case "C_Hatchback_01_sport_F": {45};
	case "C_SUV_01_F": {50};
	case "C_Van_01_transport_F": {100};
	case "C_Van_01_fuel_F": {104};
	case "I_G_Van_01_transport_F": {100};
	case "C_Van_01_box_F": {150};
	case "C_Boat_Civil_01_F": {100};
	case "C_Boat_Civil_01_police_F": {100};
	case "C_Boat_Civil_01_rescue_F": {100};
	case "B_Truck_01_box_F": {500};
	case "B_Truck_01_transport_F": {400};
	case "B_MRAP_01_F": {50};
	case "O_MRAP_02_F": {50};
	case "I_MRAP_03_F": {50};
	case "B_Heli_Light_01_F": {50}; /*LittleBird*/
	case "O_Heli_Light_02_unarmed_F": {100}; /*ORCA*/
	case "I_Heli_Transport_02_F": {175}; /*Mohawk*/
	case "C_Rubberboat": {50};
	case "B_G_Boat_Transport_01_F": {50};
	case "B_Boat_Transport_01_F": {50};
    case "Land_Box_AmmoOld_F": {700};
    case "CargoNet_01_box_F": {700};
	case "Box_IND_Wps_F": {20};
	case "I_supplyCrate_F": {40};
	case "Land_CargoBox_V1_F": {5000};
	case "Land_PlasticCase_01_large_F": {350};
	case "B_Truck_01_fuel_F": {370};
	case "O_Truck_03_covered_F": {350};
	case "O_Truck_03_transport_F": {350};
	case "O_Truck_03_fuel_F": {320};
	case "O_Truck_03_device_F": {300};
	case "B_Truck_01_covered_F": {400};
	case "B_Heli_Transport_01_F": {100};
	case "C_Kart_01_F": {-1};
	case "B_Heli_Transport_03_F": {200};
	case "B_Heli_Transport_03_unarmed_F": {200};
	case "O_Heli_Transport_04_F": {100};
	case "O_Heli_Transport_04_ammo_F": {120};
	case "O_Heli_Transport_04_box_F": {150};
	case "O_Heli_Transport_04_medevac_F": {120};
	case "O_Heli_Transport_04_fuel_F": {120};
	case "O_Heli_Transport_04_bench_F": {100};
	case "O_Heli_Transport_04_repair_F": {100};
	case "O_Heli_Transport_04_covered_F": {120};
	case "C_Heli_Light_01_civil_F": {50};
	case "I_G_Offroad_01_F": {65};
	case "B_Truck_01_mover_F": {150};
	default {20};
};
/*
	File: fn_clearVehicleAmmo.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Clears the vehicle of ammo types that we don't want.
*/
private["_vehicle","_veh"];
_vehicle = param [0,Objnull,[Objnull]];
_veh = typeOf _vehicle;

if(_veh in["B_Heli_Transport_01_F","B_Heli_Transport_03_F","B_Heli_Transport_03_black_F"]) then
{
	_vehicle removeWeaponTurret ["LMG_Minigun_Transport",[1]];
	_vehicle removeWeaponTurret ["LMG_Minigun_Transport2",[2]];
	_vehicle addWeaponTurret ["M134_minigun",[1]];
	_vehicle addWeaponTurret ["M134_minigun",[2]];
	_vehicle addMagazineTurret ["5000Rnd_762x51_Belt",[1]];
	_vehicle addMagazineTurret ["5000Rnd_762x51_Belt",[2]];
};
if(_veh == "B_Boat_Armed_01_minigun_F") then
{
	_vehicle removeMagazinesTurret ["200Rnd_40mm_G_belt",[0]];
	_vehicle removeWeaponTurret ["LMG_Minigun",[1]];
	_vehicle addWeaponTurret ["LMG_M200",[1]];
	_vehicle addMagazineTurret ["1000Rnd_65x39_Belt_Tracer_Red",[1]];
};
if(_veh == "I_G_Offroad_01_armed_F") then
{
	_vehicle removeMagazinesTurret ["100Rnd_127x99_mag_Tracer_Yellow",[0]];
};
if(_veh == "B_UAV_02_F") then 
{
	_vehicle removeWeaponTurret ["missiles_SCALPEL",[0]];
};
if(_veh == "O_MRAP_02_F") then  /*No more horn spam*/
{
	_vehicle removeWeaponTurret ["TruckHorn",[0]];
};
if(_veh == "I_MRAP_03_F") then  /*No more horn spam*/
{
	_vehicle removeWeaponTurret ["TruckHorn",[0]];
}
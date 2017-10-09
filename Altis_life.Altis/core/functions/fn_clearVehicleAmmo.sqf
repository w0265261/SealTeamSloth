/*
	File: fn_clearVehicleAmmo.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Clears the vehicle of ammo types that we don't want.
*/
private["_vehicle","_veh","_tax","_magTax","_MagazineCount","_WeaponCount","_arrayItem","_arrayItemCount","_arrayMagazine","_weaponNumber","_arrayMagazineCount","_arrayWeapon","_weaponTax","_arrayWeaponCount","_cargo","_itemCount","_magNumber"];
_vehicle = param [0,Objnull,[Objnull]];
_cargo = param [1,[],[[]]];
if(isNull _vehicle) exitWith {}; /*DAFUQ*/
_veh = typeOf _vehicle;

clearWeaponCargoGlobal _vehicle;
clearMagazineCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
if(count _cargo != 0) then {
	_itemCount = count (_cargo select 0);
	for "_i" from 0 to (_itemCount - 1) step 1 do
	{
        _arrayItem = (_cargo select 0) select _i;
        _arrayItemCount = (_cargo select 1) select _i;
        _vehicle addItemCargoGlobal [_arrayItem,_arrayItemCount];      
	};
};
if(!("U_I_Wetsuit" in (getItemCargo _vehicle select 0)) && playerSide == independent) then {
_vehicle addItemCargoGlobal ["U_I_Wetsuit",1]; };
if(!("V_RebreatherIA" in (getItemCargo _vehicle select 0)) && playerSide == independent) then {
_vehicle addItemCargoGlobal ["V_RebreatherIA",1]; };
if(!("G_Diving" in (getItemCargo _vehicle select 0)) && playerSide == independent) then {
_vehicle addItemCargoGlobal ["G_Diving",1]; };
if(!("FirstAidKit" in (getItemCargo _vehicle select 0))) then {
 _vehicle addItemCargoGlobal ["FirstAidKit",2]; };
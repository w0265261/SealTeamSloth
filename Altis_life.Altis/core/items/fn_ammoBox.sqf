/*
File: fn_ammoBox.sqf
Author: Kevin Webb
Description: Spawns an ammo box for multi-purpose use.
mainly for the IgiLoad script.
*/
private["_crate"];
_crate = param [0,"",[""]];
switch (_crate) do
{
	case "ammoBox": { _crate = "I_supplyCrate_F" createVehicle position player; life_carryweight = life_carryweight - 30; };
	case "ammoBoxS": { _crate = "Box_IND_Wps_F" createVehicle position player; life_carryweight = life_carryweight - 15; }; 
};
_crate attachTo[player,[0,5,0]];
detach _crate;
player reveal _crate;
hint "You have deployed a storage crate.";
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

_crate allowDamage false;
player setVariable["myCrate",true,true];
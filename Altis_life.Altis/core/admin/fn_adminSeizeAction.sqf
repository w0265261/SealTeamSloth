/*
	Created by: Kevin for admin seize
	Function Name: adminSeizeAction.sqf
	Description: Removes Players Weapons after RDM
	Adapted from the generic seize weapons script
*/

private["_admin"];
_admin = param [0,Objnull,[Objnull]];
if(isNull _cop) exitWith {};

player removeWeapon (primaryWeapon player);
player removeWeapon (handgunWeapon player);
clearWeaponCargo (vestContainer player);
clearWeaponCargo (backpackContainer player);
clearWeaponCargo (uniformContainer player);
clearMagazineCargo (vestContainer player);
clearMagazineCargo (backpackContainer player);
clearMagazineCargo (uniformContainer player);
license_civ_bh = false;
player setVariable["bountyHunter",false,true];
if(life_inv_boltcutter > 0) then {[false,"boltcutter",life_inv_boltcutter] call life_fnc_handleInv;};
if(life_inv_blastingCharge > 0) then {[false,"blastingcharge",life_inv_blastingcharge] call life_fnc_handleInv;};

[2] call SOCK_fnc_updatePartial;
[] call life_fnc_saveThat;
titleText [format["Since you broke the rules by random deathmatching, your weapons have been removed by Admin %1.",name _admin],"PLAIN"];
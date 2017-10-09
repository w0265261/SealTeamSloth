/*
	Created by: Kevin
	File: fn_seizePlayerWeaponAction.sqf
	Description: Removes Players Illegal Items & Weapons
*/

private["_cop","_items","_weapons","_pubCop"];

_cop = param [0,Objnull,[Objnull]];
if(isNull _cop) exitWith {};
_civ = param[1,false];
if(_civ) exitWith {
	_weaponHolder = objNull;
	if(primaryWeapon player != "") then {
		_weaponHolder = "WeaponHolderSimulated" createVehicle position player;
		_weaponHolder addWeaponCargoGlobal [primaryWeapon player,1];
		{_weaponHolder addItemCargoGlobal [_x,1]} forEach primaryWeaponItems player;
		player removeWeapon primaryWeapon player;
	};
	if(handgunWeapon player != "") then {
		if(isNull _weaponHolder) then {_weaponHolder = "WeaponHolderSimulated" createVehicle position player};
		_weaponHolder addWeaponCargoGlobal [handgunweapon player,1];
		{_weaponHolder addItemCargoGlobal [_x,1]} forEach handgunItems player;
		player removeWeapon handgunWeapon player;
	};
	if(!isNull _weaponHolder) then {
		_test = magazines player;
		{_weaponHolder addMagazineCargoGlobal [_x,1]; player removeMagazine _x} forEach _test;
	};
	titleText [format["Your weapons have been robbed by %1.",name _cop],"PLAIN"];
};
player removeWeapon (primaryWeapon player);
player removeWeapon (handgunWeapon player);
clearWeaponCargo (vestContainer player);
clearWeaponCargo (backpackContainer player);
clearWeaponCargo (uniformContainer player);
clearMagazineCargo (vestContainer player);
clearMagazineCargo (backpackContainer player);
clearMagazineCargo (uniformContainer player);
titleText [format["Your weapons have been seized by %1.",name _cop],"PLAIN"];
license_civ_gun = false;
[] call life_fnc_saveThat;
[2] call SOCK_fnc_updatePartial;
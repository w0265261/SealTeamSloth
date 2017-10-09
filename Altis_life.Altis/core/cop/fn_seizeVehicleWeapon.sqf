/*
Author: Mike McCrow
Purpose: Allows Cops to remove weapons and ammo from vehicle, before impounding.
*/
private["_pubCop"];

_pubCop = player getVariable["rank",0];
if(_pubCop < 1) exitWith {hint "No Seizing for Public Cops. Contact a Whitelisted Officer.";};

_vehicle = param [0,ObjNull,[ObjNull]];
If(isNull _vehicle || !alive _vehicle) exitWith {};
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
closeDialog 0;
titleText ["Weapons successfully removed.","PLAIN"];
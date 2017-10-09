#include <macro.h>
/*
file: fn_handleCrate.sqf
Author: Kevin Webb
Description: Deletes the crate
*/
private["_crate"];
_crate = param [0,ObjNull,[ObjNull]];
if(__GETC__(style) > 0 || playerSide != civilian) then {
	deleteVehicle _crate;
};
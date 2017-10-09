/*
	File: fn_seizeWeapon.sqf
	Author: Skalicon
	
	Description:

*/
private["_pubCop"];

_pubCop = player getVariable "rank";
if(_pubCop < 1) exitWith {hint "No Seizing for Public Cops. Contact a Whitelisted Officer.";};

_clear = nearestObjects [player,["weaponholder"],3];
_clear = _clear + nearestObjects [player,["GroundWeaponHolder"],3];
_clear = _clear + nearestObjects [player,["WeaponHolderSimulated"],3];
_destroyed = 0;

for "_i" from 0 to count _clear - 1 
do {
	_destroyed = _destroyed + 1;
	deleteVehicle (_clear select _i);
};

if(_destroyed > 0) then {
	titleText[format["Seized %1 ground objects in the vicinity.", _destroyed],"PLAIN"];
};
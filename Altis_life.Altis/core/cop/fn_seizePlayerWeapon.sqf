/*
	Created by: DirtDiver for STS
	Function Name:life_fnc_seizePlayerIllegalAction
	Description: Action for seizing illegal items
	Adapted from: Skalicon
*/
private["_pubCop"];
_unit = param [0,Objnull,[Objnull]];

_pubCop = player getVariable "rank";
if(_pubCop < 1) exitWith {hint "No Seizing for Public Cops. Contact a Whitelisted Officer.";};

if(isNull _unit) exitWith {};
if(player distance _unit > 4) exitWith {};
_vehicle = ObjNull;
_nearVehicles = nearestObjects[getPos player,["Car","Air","Ship"],30]; /*Fetch vehicles within 30m.*/
{
	if(_x getVariable["copcar",false]) exitWith {_vehicle = _x};
} foreach _nearVehicles;

if(!isNull _vehicle) then {
	if(primaryWeapon _unit != "") then {
		_vehicle addWeaponCargoGlobal[primaryWeapon _unit,1];
		{_vehicle addItemCargoGlobal [_x,1]} forEach primaryWeaponItems _unit;
	};
	if(handgunWeapon _unit != "") then {
		_vehicle addWeaponCargoGlobal[handgunWeapon _unit,1];
		{_vehicle addItemCargoGlobal [_x,1]} forEach handgunItems _unit;
	};
	hint "Suspect's weapons on hand were moved to the nearest police vehicle!"
} else {
	titleText [format["Seized weapons from %1", name _unit],"PLAIN"];
};

[player] remoteExec ["life_fnc_seizePlayerWeaponAction",_unit];
/*
	File: fn_pickupObject.sqf
	Author: John "Paratus" VanderZwet
	
	Description:
	Removes a placed object from the world.
*/
private ["_item","_index","_object"];

_item = cursorTarget;
if (isNull _item) then
{
	_item = param [3,ObjNull,[ObjNull]];
	if (isNull _item) exitWith {};
};

_index = [typeOf _item, life_placeable] call fnc_index;
if (_index < 0) exitWith {hint "This item cannot be picked up."};
if (isNull (_item getVariable ["owner",objNull])) exitWith { deleteVehicle _item; hint "It appears the owner has gone offline, so this object has been deleted."; };

_placable = life_placeable select _index;
if (!([true,_placable select 0,1] call life_fnc_handleInv)) exitWith { hint format["You don't have room in your inventory for a %1.", _placable select 2] };

hint format["You picked up a %1.", _placable select 2];
deleteVehicle _item;
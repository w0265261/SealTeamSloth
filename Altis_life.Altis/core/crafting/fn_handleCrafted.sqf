/*
fn_handleCrafted
Kevin Webb
handles rewarding the crafted item
case 0: item
case 1: weapon
*/
private["_vehicle","_nearvehicles"];
_item = param [0,"",[""]];
_case = param [1,-1,[0]];
_nearVehicles = nearestObjects[getPos (player),["Car","Air","Ship"],50];
if(count _nearVehicles > 0) then
{
	{
		if(!isNil "_vehicle") exitWith {}; /*Kill the loop.*/
		_vehData = _x getVariable["vehicle_info_owners",[]];
		if(count _vehData  > 0) then
		{
			_vehOwner = (_vehData select 0) select 0;
			if((getPlayerUID player) == _vehOwner || _x in life_vehicles) exitWith
			{
				_vehicle = _x;
			};
		};
	} foreach _nearVehicles;
};
if(isNil "_vehicle") exitWith {
	if(backPack player != "") then {
		switch(_case) do
		{
			case 0: {(backpackContainer player) addItemCargoGlobal [_item,1];};
			case 1: {(backpackContainer player) addWeaponCargoGlobal [_item,1];};
		};
	} else {
		switch(_case) do
		{
			case 0: {player addItem _item;};
			case 1: {player addWeapon _item;};
		};
	};
};
switch(_case) do
{
	case 0: {_vehicle addItemCargoGlobal [_item,1];};
	case 1: {_vehicle addWeaponCargoGlobal [_item,1];};
};
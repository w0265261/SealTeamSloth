/*
fn_initLocker.sqf
Kevin Webb
Description: Sets up our police officer's locker.
*/
_cargo = life_cargo;
//Find inactive container
for [{_i=1},{_i<=35},{_i=_i+1}] do {
	_var = format["locker_1_%1",_i];
	_box = missionNameSpace getVariable _var;
	sleep (random 5);
	if(_box getVariable["owner",""] == "") exitWith {
		_box setVariable["owner",getPlayerUID player,true];
		clearWeaponCargoGlobal _box;
		clearMagazineCargoGlobal _box;
		clearItemCargoGlobal _box;
		clearBackpackCargoGlobal _box;
		if(count _cargo == 0) exitWith {
			_box hideObject false;
			_marker = createMarkerLocal ["My Locker",position _box];
			_marker setMarkerTypeLocal "b_support";
			_marker setMarkerTextLocal "My Locker";
		};
		_weapons = (_cargo select 0);
		_magazines = (_cargo select 1);
		_items = (_cargo select 2);
		_backpacks = (_cargo select 3);
		
		/*Add weapons to the crate.*/
		{
			_weaponCount = (_weapons select 1) select _forEachIndex;
			_box addWeaponCargoGlobal [_x,_weaponCount];
		} foreach (_weapons select 0);
		
		/*Add magazines*/
		{
			_magazineCount = (_magazines select 1) select _forEachIndex;
			_box addMagazineCargoGlobal [_x,_magazineCount];
		} foreach (_magazines select 0);
			
		/*Add items*/
		{
			_itemCount = (_items select 1) select _forEachIndex;
			_box addItemCargoGlobal [_x,_itemCount];
		} foreach (_items select 0);
		
		/*Add backpacks*/
		{
			_backpackCount = (_backpacks select 1) select _forEachIndex;
			_box addBackpackCargoGlobal [_x,_backpackCount];
		} foreach (_backpacks select 0);
		_box hideObject false;
		_marker = createMarkerLocal ["My Locker",position _box];
		_marker setMarkerTypeLocal "b_support";
		_marker setMarkerTextLocal "My Locker";
	};
};
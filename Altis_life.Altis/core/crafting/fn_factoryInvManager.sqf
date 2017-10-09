/*
	File: fn_factoryInvManager.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Stores or takes the item from the factory inventory. The inventory is an array with the count and item alternating. 
	Example: ([3,0,8,15])
		There are 3 items with craftID of 0
		There are 8 items with craftID of 15
	
	Arguments:
	_store (true if the item should be added to the factory's inventory, false if it should be taken out of the inventory)
	_item (the item to store or take from the factory inventory)
	_count (how many of the item to take or put into the inventory)
	
	Attribute ids (listed in CfgRecipes):
	0 - craftID (Only for non-Terminal Items).
	1 - displayName
	2 - recipe
	3 - recipeIngredientCount
	4 - creationTime
*/
private ["_store", "_item", "_count", "_inventory", "_i", "_appendCurrentCount"];

_store = param [ 0, false, [true]];
_item = param [ 1, "", [""]];
_count = param [ 2, -1, [0]];

if(_item == "") exitWith {hint "ERROR: _item wasn't defined. (fn_factoryInvManager.sqf)"};
if(_count == -1) exitWith {hint "ERROR: _count wasn't defined. (fn_factoryInvManager.sqf)"};

_craftID = [_item, 0, false] call life_fnc_getCraftItemAttr;
_inventory = factoryInv;

if(_store) then{
	_currentCount = 0;
	_i = 1;/*must start at 1 for modulus to work properly*/
	{
		if(_x == _craftID && _i % 2 == 0) exitWith{
			_currentCount = _inventory select (_i - 1 - 1);
			_inventory set[_i - 1 - 1, _count];
		};
		_i = _i + 1;
	}forEach _inventory;
	
	if(_currentCount == 0) then{
		_inventory = _inventory + [_count];
		_inventory = _inventory + [_craftID];
	};
}else{
	if(count _inventory == 0) exitWith {hint "ERROR: Can't take an item from the factory inventory if it is empty. (fn_factoryInvManager.sqf)"};
	if((count _inventory) % 2 != 0) exitWith {hint "ERROR: Factory inventory has wrong format. (fn_factoryInvManager.sqf)"};
	
	_i = 1;/*must start at 1 for modulus to work properly*/
	_currentCount = 0;
	{
		if(_x == _craftID && _i % 2 == 0) exitWith{
			_currentCount = _inventory select _i - 1 - 1;
		};
		_i = _i + 1;
	}forEach _inventory;
	
	if(_currentCount > _count) then{
		_inventory set[_i - 1 - 1, _currentCount - _count];
	}else{
		_inventory deleteAt (_i - 1) - 1; /*-1 to get the count of the item and then another -1 because we started counting at 1*/
		_inventory deleteAt (_i - 1) - 1; /*-1 to get to the the item and then another -1 because we started counting at 1		*/
	};
};

factoryInv = _inventory;
[getPlayerUID player, playerSide, _inventory, 9] remoteExec ["DB_fnc_updatePartial",2];
/*
	File: fn_loadCraftingMenu.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Creates the crafting menu.
	
	Arguments:
	None
	
	Attribute ids (listed in CfgRecipes):
	0 - craftID
	1 - displayName
	2 - recipe
	3 - recipeIngredientCount
	4 - creationTime
*/

private ["_ctrl", "_index", "_item", "_configs","_displayName", "_inventory", "_i", "_dataName"];

disableSerialization;

createDialog "CraftingMenu";

/* player inventory*/
_ctrl = (findDisplay 44000) displayCtrl 44001;
{
	_displayName = [_x] call life_fnc_varToStr;
	_val = missionNameSpace getVariable _x;
	if(_val > 0) then
	{
		_index = _ctrl lbAdd format["%1x %2",_val,_displayName];
		_ctrl lbSetData [_index, _x];
		_ctrl lbSetValue [_index, _val];
	};
} forEach life_inv_items;


/* manufacturable list*/
_configs = ("true" configClasses (missionConfigFile >> "CfgRecipes" >> "TerminalItems")); 
_ctrl = (findDisplay 44000) displayCtrl 44004;
{
	_item = configName (_x);
	_displayName = [_item, 1, true] call life_fnc_getCraftItemAttr;
	
	_index = _ctrl lbAdd (_displayName);
	_ctrl lbSetData [_index, _item];
} forEach _configs;


/* factory inventory*/
_ctrl = (findDisplay 44000) displayCtrl 44002;
_inventory = factoryInv;
_i= 0;

while {_i + 1 < count _inventory} do{
	_configs = (format["getNumber(_x >> 'craftID') == %1", _inventory select (_i + 1)] configClasses (missionConfigFile >> "CfgRecipes" >> "Ingredients"));
	_val = _inventory select _i;
	_dataName = configName (_configs select 0);
	_displayName = [_dataName, 1, false] call life_fnc_getCraftItemAttr;
	_index = _ctrl lbAdd format["%1x %2",_val,_displayName];
	_ctrl lbSetData [_index, _dataName];
	_ctrl lbSetValue [_index, _val];
	_i= _i + 2;
};


/*
	File: fn_getCraftItemAttr.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Returns the specified attribute about the designated crafting item.
	
	Arguments:
	_craftItem (_item to get config of)
	_attributeSelect (int attribute to select; read below)
	_isTerminal (true if the item is terminal, false otherwise)
	
	Attribute ids (listed in CfgRecipes):
	0 - craftID
	1 - displayName
	2 - recipe
	3 - recipeIngredientCount
	4 - creationTime
	5 - onCreation (only for Terminal Items)
*/
private["_craftItem","_attributeSelect", "_isTerminal", "_data", "_itemType"];

_craftItem = param [ 0, "", [""]];
_attributeSelect = param [ 1, 0, [0]];
_isTerminal = param [ 2, false, [true]];

_itemType = "";

if(_isTerminal) then{
	_itemType = "TerminalItems";
}else{
	_itemType = "Ingredients";
};

_data = [];

switch (_attributeSelect) do{
	case 0: {
		_data = ["CfgRecipes", "Ingredients", _craftItem, "craftID"] call BIS_fnc_getCfgData;
	};
	case 1: {
		_data = ["CfgRecipes", _itemType, _craftItem, "displayName"] call BIS_fnc_getCfgData;
	};
	case 2: {
		_data = ["CfgRecipes", _itemType, _craftItem, "recipe"] call BIS_fnc_getCfgData;
	};
	case 3: {
		_data = ["CfgRecipes", _itemType, _craftItem, "recipeIngredientCount"] call BIS_fnc_getCfgData;
	};
	case 4: {
		_data = ["CfgRecipes", _itemType, _craftItem, "creationTime"] call BIS_fnc_getCfgData;
	};
	case 5: {
		_data = ["CfgRecipes", "TerminalItems", _craftItem, "onCreation"] call BIS_fnc_getCfgData;
	};
};

_data;
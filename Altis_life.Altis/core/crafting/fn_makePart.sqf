/*
	File: fn_makePart.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Called after a user pushes craft ingredient button. Checks to see if the ingredients are present in the player inventory or the factory inventory. 
	If they are, it deducts them and adds the ingredient to the factory inventory.
	
	Arguments:
	_craftTwice (if true it will craft the ingredient twice)

	Attribute ids (listed in CfgRecipes):
	0 - craftID
	1 - displayName
	2 - recipe
	3 - recipeIngredientCount
	4 - creationTime
*/
private["_craftTwice", "_ingredient", "_ctrl", "_recipe", "_missing", "_ctrlFInv", "_i", "_recipeIngredientCount", "_displayName"];

disableSerialization;

_craftTwice = param [ 0, false, [true]];

_ctrl = (findDisplay 44000) displayCtrl 44008;     /* part list*/
_ctrlFInv = (findDisplay 44000) displayCtrl 44002; /* factory inventory*/
_ingredient = _ctrl lbData (lbCurSel _ctrl); /*part selected*/

if(lbCurSel _ctrl == -1)exitWith{
	hint "No part selected.";
};

_recipe = [_ingredient, 2, false] call life_fnc_getCraftItemAttr;
_recipeIngredientCount = [_ingredient, 3, false] call life_fnc_getCraftItemAttr;

if(count _recipe != count _recipeIngredientCount) exitWith{
	hint format["ERROR: The recipe array length doesn't equal the ingredient count array for item ""%1"" (fn_makePart.sqf)", _ingredient];
};


if(_craftTwice) then{
	{
		_recipeIngredientCount set[_forEachIndex, (_recipeIngredientCount select _forEachIndex) * 2];
	}forEach _recipeIngredientCount;
};

_missing = [_ingredient, _recipe, false, _craftTwice] call life_fnc_isCraftable;
_displayName = [_ingredient, 1, false] call life_fnc_getCraftItemAttr;

if(count _missing > 0) exitWith {
	hint format["You don't have the required materials for %1.", _displayName];
	_ctrl = (findDisplay 44000) displayCtrl 44005;
	lbClear _ctrl;
	{
		_ctrl lbAdd (_missing select _forEachIndex);
	}forEach _missing;
};

[_recipe, _recipeIngredientCount] call life_fnc_updateResources;

[_ingredient, false, _craftTwice] spawn life_fnc_giveCraftedItem;
/*
	File: fn_manufactureItem.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Called once the manufacture button is pressed. Checks to see if the all the parts are present in the player inventory or the factory inventory. 
	If they are, it deducts them and then calls the selected terminal item's (or manufacture item's) onCreation function to give the player what they created (good or bad :) ).
	
	Arguments:
	None

	Attribute ids (listed in CfgRecipes):
	0 - craftID
	1 - displayName
	2 - recipe
	3 - recipeIngredientCount
	4 - creationTime
*/
private["_termItem", "_ctrl", "_recipe", "_missing", "_i", "_recipeIngredientCount", "_displayName"];

_ctrl = (findDisplay 44000) displayCtrl 44004;     /* manufacturing/terminal items list*/
_termItem = _ctrl lbData (lbCurSel _ctrl); /* manufacturing/terminal item selected*/

if(lbCurSel _ctrl == -1) exitWith{
	hint "No manufacturable item selected.";
};

_recipe = [_termItem, 2, true] call life_fnc_getCraftItemAttr;
_recipeIngredientCount = [_termItem, 3, true] call life_fnc_getCraftItemAttr;

if(count _recipe != count _recipeIngredientCount) exitWith{
	hint format["ERROR: The recipe array length doesn't equal the ingredient count array for item ""%1"" (fn_manufactureItem.sqf)", _termItem];
};
_i = 0;
_missing = [_termItem, _recipe, true] call life_fnc_isCraftable;
_displayName = [_termItem, 1, true] call life_fnc_getCraftItemAttr;

if(count _missing > 0) exitWith {
	hint format["You don't have the required parts for %1.", _displayName];
	_ctrl = (findDisplay 44000) displayCtrl 44005;
	lbClear _ctrl;
	{
		_ctrl lbAdd (_missing select _i);
		_i = _i + 1;
	}forEach _missing;
};

[_recipe, _recipeIngredientCount] call life_fnc_updateResources;
[_termItem, true, false] spawn life_fnc_giveCraftedItem;

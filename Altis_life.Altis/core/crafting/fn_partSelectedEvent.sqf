/*
	File: fn_partSelectedEvent.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Adds all items that make up the selected part into the materials list.
	
	Arguments:
	None
	
	Attribute selection numbers for getCraftItemAttr
	0 - craftID
	1 - displayName
	2 - recipe
	3 - recipeIngredientCount
	4 - creationTime
*/

private ["_item", "_recipe","_index", "_i", "_displayName", "_howMany", "_ctrlMaterialList", "_ctrlPartList"];

_ctrlPartList = (findDisplay 44000) displayCtrl 44008;
_ctrlMaterialList = (findDisplay 44000) displayCtrl 44009;
lbClear _ctrlMaterialList;

_item = _ctrlPartList lbData (lbCurSel _ctrlPartList);
if (_item select [0,4] == "life") exitWith {_ctrlMaterialList lbAdd "No materials required.";};/*doesn't have any materials that compose it.*/

_recipe = [_item, 2, false] call life_fnc_getCraftItemAttr;
_howMany = [_item, 3, false] call life_fnc_getCraftItemAttr;

_i = 0;
_displayName = "";
{
	if (_x select [0,4] == "life") then{
		_displayName = [_x] call life_fnc_varToStr;
	}else{
		_displayName = [_x, 1, false] call life_fnc_getCraftItemAttr;
	};
	_index = _ctrlMaterialList lbAdd format["%1x %2", (_howMany select _i), _displayName];
	_ctrlMaterialList lbSetData [_index, _x];
	_ctrlMaterialList lbSetValue [_index, (_howMany select _i)];

	_i = _i + 1;
}forEach _recipe;
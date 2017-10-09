/*
	File: fn_termItemSelectedEvent.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Adds all items that make up the selected terminal item into the parts list.
	
	Arguments:
	None
	
	Attribute selection numbers for getCraftItemAttr
	0 - craftID
	1 - displayName
	2 - recipe
	3 - recipeIngredientCount
	4 - creationTime
*/

private ["_ctrlManufItem", "_item", "_recipe", "_index", "_i", "_displayName", "_howMany", "_ctrlPartList"];

_ctrlManufItem = (findDisplay 44000) displayCtrl 44004;
_item = _ctrlManufItem lbData (lbCurSel _ctrlManufItem);

_recipe = [_item, 2, true] call life_fnc_getCraftItemAttr;
_howMany = [_item, 3, true] call life_fnc_getCraftItemAttr;

_ctrlPartList = (findDisplay 44000) displayCtrl 44008;
_ctrlMaterialList = (findDisplay 44000) displayCtrl 44009;

lbClear _ctrlPartList;
lbClear _ctrlMaterialList;

_i = 0;

{
	if(_x select [0,4] == "life") then {
		/* add the life_inv part to the parts list*/
		_displayName = [_x] call life_fnc_varToStr;
		_index = _ctrlPartList lbAdd format["%1x %2", (_howMany select _i),_displayName];
		_ctrlPartList lbSetData [_index, _x];
		_ctrlPartList lbSetValue [_index, (_howMany select _i)];
	}else {
		/* add the craft_ part to the parts list*/
		_displayName = [_x, 1, false] call life_fnc_getCraftItemAttr;
		_index = _ctrlPartList lbAdd format["%1x %2", (_howMany select _i),_displayName];
		_ctrlPartList lbSetData [_index, _x];
		_ctrlPartList lbSetValue [_index, (_howMany select _i)];
	};
	_i = _i + 1;
}forEach _recipe;
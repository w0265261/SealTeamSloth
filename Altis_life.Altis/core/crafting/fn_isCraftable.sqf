/*
	File: fn_isCraftable.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Checks to see if the defined item (_item) is craftable/manufacturable with the defined recipe (_recipe). Searches the factory's virtual inventory and the player virtual inventory.
	Returns missing ingredients for the recipe. If the array is empty, no missing ingredients.
	
	Arguments:
	_item (the item to check if it is craftable with current resources)
	_recipe (recipe for _item)
	_isTerminal (if _item is a terminal item)
	
	Returns an array of strings containing the amount missing of a certain part in "%1x %2" format where %1 is quantity and %2 is the item
*/
private["_item", "_recipe", "_isTerminal", "_recipeCur", "_missing", "_i", "_displayName", "_recipeIngredientCount"];

_item = param [ 0, "", [""]];
_recipe = param [ 1, [], [[]]];
_isTerminal = param [ 2, false, [true]];
_craftTwice = param [3,false,[false]];
_recipeIngredientCount = [_item, 3, _isTerminal] call life_fnc_getCraftItemAttr;
if(_craftTwice) then{
	{
		_recipeIngredientCount set[_forEachIndex, (_recipeIngredientCount select _forEachIndex) * 2];
	}forEach _recipeIngredientCount;
};
if(_item == "") exitWith {hint format["ERROR: Item not defined (fn_isCraftable.sqf)"];};
if(count _recipe == 0) exitWith {hint format["ERROR: Empty recipe (fn_isCraftable.sqf)"];};

_ctrlPInv = (findDisplay 44000) displayCtrl 44001; /*player inventory*/
_ctrlFInv = (findDisplay 44000) displayCtrl 44002; /*factory inventory*/

_missing = [];
_recipeCur = 0;
{
	if(lbSize _ctrlFInv == 0) exitWith{};
	_i = 0;
	while{_i < lbSize _ctrlFInv} do{
		scopeName "while";
		if(_ctrlFInv lbData _i == _x) then{
			if(_ctrlFInv lbValue _i >= _recipeIngredientCount select _recipeCur) then{
				_recipeIngredientCount set[_recipeCur, 0];
			}else{
				_recipeIngredientCount set[_recipeCur, (_recipeIngredientCount select _recipeCur) - (_ctrlFInv lbValue _i)];
			};
			_recipeCur = _recipeCur + 1;
			breakOut "while";
		};
		if(_i + 1 == lbSize _ctrlFInv) then {
			_recipeCur = _recipeCur + 1;
			breakOut "while";
		};
		_i = _i + 1;
		
	};
} forEach _recipe;

_recipeCur = 0;
{
	if(lbSize _ctrlPInv == 0) exitWith{};
	_i = 0;
	while{_i < lbSize _ctrlPInv} do{
		scopeName "while";
		if(_ctrlPInv lbData _i == _x) then{
			if(_ctrlPInv lbValue _i >= _recipeIngredientCount select _recipeCur) then{
				_recipeIngredientCount set[_recipeCur, 0];
			}else{
				_recipeIngredientCount set[_recipeCur, (_recipeIngredientCount select _recipeCur) - (_ctrlPInv lbValue _i)];
			};
			_recipeCur = _recipeCur + 1;
			breakOut "while";
		};
		_i = _i + 1;
	};
} forEach _recipe;

_recipeCur = 0;
{
	if(_x > 0)then{
		if(_recipe select _recipeCur select[0,4] == "life")then{
			_displayName = [_recipe select _recipeCur] call life_fnc_varToStr;
		}else{
			_displayName = [_recipe select _recipeCur, 1, false] call life_fnc_getCraftItemAttr;
		};
		_missing = _missing + [format["%1x %2",(_recipeIngredientCount select _recipeCur), _displayName]];
	};
	_recipeCur = _recipeCur + 1;

}forEach _recipeIngredientCount;

_missing;
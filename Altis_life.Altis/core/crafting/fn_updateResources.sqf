/*
	File: fn_updateResources.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Removes all items in the recipe from the player inventory and factory inventory.
	NOTE: This should be called after an isCraftable execution to ensure this doesn't remove resources from the inventories when the recipe isn't fully complete.
	This will remove items without a check for completion of the recipe.
	
	Arguments: 
	_recipe (the recipe to check)
	_recipeIngredientCount ingredient count from the config entry of CfgRecipes)
	_craftTwice (if true, the item will take twice the amount of time to craft)
	
	Attribute ids (listed in CfgRecipes):
	0 - craftID
	1 - displayName
	2 - recipe
	3 - recipeIngredientCount
	4 - creationTime
	5 - onCreation (only for Terminal Items)
*/
private["_recipe", "_recipeIngredientCount", "_ctrlPInv", "_ctrlFInv", "_recipeCur", "_i", "_displayName", "_dataName", "_val", "_ctrl","_index"];

_recipe = param [ 0, [],[[]]];
_recipeIngredientCount = param [ 1, [],[[]]];
if(count _recipe == 0 OR count _recipeIngredientCount == 0) exitWith{hint "ERROR: _recipe or _recipeIngredientCount weren't defined. (fn_updateResources.sqf)"};

_ctrlPInv = (findDisplay 44000) displayCtrl 44001; /* player inventory*/
_ctrlFInv = (findDisplay 44000) displayCtrl 44002; /* factory inventory*/

/*Disable user input. Re-enabled when the item is given to the player.*/
_ctrl = (findDisplay 44000) displayCtrl 44010;
_ctrl ctrlEnable false;
_ctrl = (findDisplay 44000) displayCtrl 44011;
_ctrl ctrlEnable false;
_ctrl = (findDisplay 44000) displayCtrl 44006;
_ctrl ctrlEnable false;

_displayName = "";

_recipeCur = 0;
{
	if(lbSize _ctrlFInv == 0) exitWith{};
	scopeName "foreach";
	_i = 0;
	while{_i < lbSize _ctrlFInv} do{
		if(_ctrlFInv lbData _i == _x) then{
			
			[false, _x, _recipeIngredientCount select _recipeCur] call life_fnc_factoryInvManager;
			if(_ctrlFInv lbValue _i > _recipeIngredientCount select _recipeCur) then {
				if(_x select [0,4] == "life") then{
					_displayName = [_x] call life_fnc_varToStr;
				}else{
					_displayName = [_x, 1, false] call life_fnc_getCraftItemAttr;
				};
				_val = (_ctrlFInv lbValue _i) - (_recipeIngredientCount select _recipeCur);
				_index = _ctrlFInv lbAdd format["%1x - %2", _val, _displayName];
				_ctrlFInv lbDelete _i;
				_ctrlFInv lbSetData [_index, _x];
				_ctrlFInv lbSetValue [_index, _val];
			}else{
				_ctrlFInv lbDelete _i;
			};			
			_val = (_recipeIngredientCount select _recipeCur) - (_ctrlFInv lbValue _i);
			_recipeIngredientCount set[_recipeCur, (_val max 0)];
			_recipeCur = _recipeCur + 1;			
			breakTo "foreach";
		}else{
			_i = _i + 1;
		};
		
	};
} forEach _recipe;

_recipeCur = 0;
{
	if(lbSize _ctrlPInv == 0) exitWith{};
	scopeName "foreach";
	_i = 0;
	while{_i < lbSize _ctrlPInv} do{
		if(_ctrlPInv lbData _i == _x) then{
			if((_recipeIngredientCount select _recipeCur) == 0) exitWith{breakTo "foreach";};
			_dataName = [_x, 1] call life_fnc_varHandle;
			
			[false, _dataName, _recipeIngredientCount select _recipeCur] call life_fnc_handleInv;
			
			if(_ctrlPInv lbValue _i > _recipeIngredientCount select _recipeCur) then {
				_displayName = [_x] call life_fnc_varToStr;
				_val = (_ctrlPInv lbValue _i) - (_recipeIngredientCount select _recipeCur);
				_ctrlPInv lbDelete _i;
				_index = _ctrlPInv lbAdd format["%1x %2", _val, _displayName];
				_ctrlPInv lbSetData [_index, _x];
				_ctrlPInv lbSetValue [_index, _val];
			}else{
				_ctrlPInv lbDelete _i;/*intentionally including <=*/
			};
			
			_recipeCur = _recipeCur + 1;
			breakTo "foreach";
		}else{
			_i = _i + 1;
		};
	};
	
} forEach _recipe;
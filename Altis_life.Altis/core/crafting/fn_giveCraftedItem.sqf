/*
	File: fn_giveCraftedItem.sqf
	Author: Kayler "K-Town" Renslow
	
	Description:
	Gives the crafted/manufactured item to the player. If it is a terminal item, the onCreation function will be called. 
	If it is a regular craft_ item, it will be put into the factory's storage.
	
	Arguments:
	_item (the thing to be given)
	_isTerminal (is the item a terminal crafted item?)
	_craftTwice (if true, the item will take twice the amount of time to craft)
	
	Attribute ids (listed in CfgRecipes):
	0 - craftID
	1 - displayName
	2 - recipe
	3 - recipeIngredientCount
	4 - creationTime
	5 - onCreation (only for Terminal Items)
*/
private ["_item", "_isTerminal", "_craftTwice", "_i", "_ctrlFInv", "_ctrlProg", "_ctrlProgText", "_delay", "_progress", "_val", "_index", "_found", "_displayName", "_function","_pos"];

disableSerialization;

_item = param [ 0, "", [""]];
_isTerminal = param [ 1, false, [true]];
_craftTwice = param [ 2, false, [true]];

_displayName = [_item, 1, _isTerminal] call life_fnc_getCraftItemAttr;

if(_item == "") exitWith {/*hint "ERROR: _item is undefined. (fn_giveCraftedItem.sqf)"*/};

_ctrlProg = (findDisplay 44000) displayCtrl 44003;
_ctrlProgText = (findDisplay 44000) displayCtrl 44007;

_delay = [_item, 4, _isTerminal] call life_fnc_getCraftItemAttr;
_progress = 1;
if(_craftTwice) then{
	_delay = _delay * 2;
};
_pos = getPosATL player;
life_action_inUse = true;
while{_progress < _delay} do{
	_ctrlProg progressSetPosition (_progress / _delay);
	_ctrlProgText ctrlSetText format["%1%2", round ((_progress / _delay) * 100), "%"];
	sleep 1;
	if(!dialog) exitWith {};
	_progress = _progress + 1;
};
if(!dialog) then {
	/*Setup our progress bar.*/
	5 cutRsc ["life_progress","PLAIN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progres = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText "Crafting...";
	_progres progressSetPosition (_progress / _delay);
	while{_progress < _delay} do {
		sleep 1;
		_progress = _progress + 1;
		_progres progressSetPosition (_progress / _delay);
		if(player distance _pos > 25) exitWith {};
	};
} else {
	_ctrlProg progressSetPosition 1.0;
	_ctrlProgText ctrlSetText "100%";
};
life_action_inUse = false;
5 cutText ["","PLAIN"];
if(player distance _pos > 25) exitWith {hint "Since you wandered too far from the vendor, the task has failed.";};
if(!dialog) then {call life_fnc_loadCraftingMenu};
_ctrlFInv = (findDisplay 44000) displayCtrl 44002;
if(!_isTerminal) then {
	_found = false;
	_i = 0;
	_val = 0;
	while{_i < lbSize _ctrlFInv} do{
		if(_ctrlFInv lbData _i == _item) exitWith{
			_found = true;
		};
		_i = _i + 1;
	};
	if(_found) then{
		_val = (_ctrlFInv lbValue _i) + 1;
		if(_craftTwice) then {
			_val = _val + 1;
		};
		_ctrlFInv lbDelete _i;
		_index = _ctrlFInv lbAdd format["%1x %2", _val, _displayName];
		_ctrlFInv lbSetData [_index, _item];
		_ctrlFInv lbSetValue [_index, _val];
	}else{
		_val = 1;
		if(_craftTwice) then{
			_val = 2;
		};
		_index = _ctrlFInv lbAdd format["%1x %2", _val, _displayName];
		_ctrlFInv lbSetData [_index, _item];
		_ctrlFInv lbSetValue [_index, _val];
	};
	
	[true, _item, _val] call life_fnc_factoryInvManager;
	
}else{
	_function = [_item, 5, true] call life_fnc_getCraftItemAttr;
	[_item] call compile _function;
};

_ctrl = (findDisplay 44000) displayCtrl 44010;
_ctrl ctrlEnable true;
_ctrl = (findDisplay 44000) displayCtrl 44011;
_ctrl ctrlEnable true;
_ctrl = (findDisplay 44000) displayCtrl 44006;
_ctrl ctrlEnable true;
#include <macro.h>
/*
	File: fn_virt_update.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Update and fill the virtual shop menu.
*/
private["_display","_item_list","_gear_list","_shop_data","_name","_price","_marketprice"];
disableSerialization;
_setup = param [0,true,[true]];
/*Setup control vars.*/
_display = findDisplay 2400;
_item_list = _display displayCtrl 2401;
_gear_list = _display displayCtrl 2402;

/*Purge list*/

_shop_data = [life_shop_type] call life_fnc_virt_shops;
lbClear _gear_list;
if(_setup) then {
lbClear _item_list;
_str = if(life_virt_shop in["rebel","gang"]) then {"%1"} else {"%1; Tax: %2%3"};
ctrlSetText[2403,format[_str, _shop_data select 0, life_rules select 1, "%"]];
{
	_name = [([_x,0] call life_fnc_varHandle)] call life_fnc_vartostr;
	_index = [_x,buy_array] call fnc_index;
	if(_index != -1) then
	{
		_price = (buy_array select _index) select 1;
		_marketprice = [_x] call life_fnc_marketGetBuyPrice;
		if(!(_marketprice in [0,-1]) && !isNil "_marketPrice") then
		{
			_price = _marketprice;
		};
		if(isNil "_price" || _price == 0) then {
			_price = (buy_array select _index) select 1;
		};
		if(!(life_virt_shop in["rebel","gang"])) then {_price = _price * (1 + ((life_rules select 1) / 100))};
		_price = floor _price;
		if(_setup) then {
		_item_list lbAdd format["%1  ($%2)",_name,[_price] call life_fnc_numberText];
		_item_list lbSetData [(lbSize _item_list)-1,_x];
		_item_list lbSetValue [(lbSize _item_list)-1,_price];
		_item_list lbSetTooltip [(lbSize _item_list)-1, format["%1  ($%2)",_name,[_price] call life_fnc_numberText]];
		};
	};
} foreach (_shop_data select 1);
};
[_shop_data select 1] spawn life_fnc_marketShortView;
{
	_var = [_x,0] call life_fnc_varHandle;
	_val = missionNameSpace getVariable _var;
	_name = [_var] call life_fnc_vartostr;
	
	if(_val > 0) then
	{
		_gear_list lbAdd format["%1x %2",_val,_name];
		_gear_list lbSetData [(lbSize _gear_list)-1,_x];
		_gear_list lbSetTooltip [(lbSize _gear_list)-1, format["%1x %2",_val,_name]];
	};
} foreach (_shop_data select 1);

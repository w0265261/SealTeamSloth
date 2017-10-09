#include <macro.h>
/*
	File: fn_virt_sell.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Sell a virtual item to the store / shop
*/
private["_type","_index","_price","_var","_amount","_name","_msg","_msg2","_marketprice"];
_msg = "Hack Alert The player with the above name might be hacking! He just tried to sell more items than can traditionally be carried.";
if(life_carryWeight > 75) exitWith { 
	[3,-1,_msg] call life_fnc_newMsg;
	hintSilent "Hmm, something went wrong. Try selling a lower amount.";
};
if((lbCurSel 2402) == -1) exitWith {};
_type = lbData[2402,(lbCurSel 2402)];
_index = [_type,sell_array] call fnc_index;
if(_index == -1) exitWith {};
_price = (sell_array select _index) select 1;
_var = [_type,0] call life_fnc_varHandle;
_marketprice = [_type] call life_fnc_marketGetSellPrice;
if(!isNil "_marketPrice") then {
if(!(_marketprice in [0,-1])) then
{
	_price = _marketprice;
};
};
if(isNil "_price") then { _price = (sell_array select _index) select 1; };
if(_price == 0) then {_price = (sell_array select _index) select 1; };
_amount = ctrlText 2405;
if(!([_amount] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number";};
_amount = parseNumber (_amount);
if(_amount > (missionNameSpace getVariable _var)) exitWith {hint "You don't have that many items to sell!"};
if(_amount > 75) exitWith { 
	[3,-1,_msg] call life_fnc_newMsg;
	hintSilent "Hmm, something went wrong. Try selling a lower amount.";
};
if(isNil "_price") then { _price = 50; };
_price = (_price * _amount);
_name = [_var] call life_fnc_vartostr;
if(([false,_type,_amount] call life_fnc_handleInv)) then
{
	systemChat format["You sold %1 %2 for $%3",_amount,_name,[_price] call life_fnc_numberText];
	if(_marketprice != -1 && !isNil "_type" && !isNil "_amount") then 
    {
		if(count life_market == 0) then {
			life_market pushBack [_type,_amount];
			[] spawn
			{
				sleep 60;
				{[_x select 0,_x select 1] call life_fnc_marketSell} forEach life_market;
				life_market = [];
			};
		} else {
			_handled = false;
			for [{_x=0},{_x < (count life_market)},{_x=_x+1}] do {
				if(((life_market select _x) select 0) == _type) exitWith {
					life_market set[_x,[_type,(_amount + ((life_market select _x) select 1))]];
					_handled = true;
				};
			};
			if(!_handled) then {life_market pushBack [_type,_amount]};
		};
    };

["cash","add",_price] call life_fnc_handlePaper;
PlaySound "purchase";
[false] call life_fnc_virt_update;
};

if(life_shop_type in["heroin","moonshine","wongs"]) then
{
	_array = life_shop_npc getVariable["sellers",[]];
	_ind = [getPlayerUID player,_array] call fnc_index;
	if(_ind == -1) then {
		_array pushBack [getPlayerUID player,profileName];
		life_shop_npc setVariable["sellers",_array,true];
	};
};

_index = [_type,life_sold] call fnc_index;
if (_index < 0) then {
	life_sold pushBack [_type,_amount];
} else {
	_thisitem = life_sold select _index;
	_newcount = (_thisitem select 1) + _amount;
	life_sold set [_index,[_type,_newcount]];
};	
life_moneyMade = life_moneyMade + _price;


if(!(life_isSelling)) then {
	life_isSelling = true;
	[] spawn
	{
		sleep 300;
		call life_fnc_salesCheck;
		life_isSelling = false;
		life_sold = [];
		life_moneyMade = 0;
	};
};
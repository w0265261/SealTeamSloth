#include <macro.h>
/*
	File: fn_weaponShopSelection.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Checks the weapon & adds the price tag.
*/
private["_control","_index","_priceTag","_price","_item"];
_control = param [0,controlNull,[controlNull]];
_index = param [1,-1,[0]];
if(isNull _control OR _index == -1) exitWith {closeDialog 0;}; /*Bad data*/

_priceTag = ((findDisplay 38400) displayCtrl 38404);
_item = _control lbData _index;
_price = 0;
_prestigePrice = 0;
_prestige = false;

_iS = [_item,life_weapon_shop_array] call fnc_index;

if(_iS != -1) then 
{
	_price = (life_weapon_shop_array select _iS) select 1;
};

if((uiNamespace getVariable["Weapon_Shop_Filter",0]) == 1) then
{
	_price = (_price / 5); //You get one fifth of the buy price back when you sell it.
	_priceTag ctrlSetStructuredText parseText format ["<t size='0.8'>Price: <t color='#8cff9b'>$%1</t></t>",[(_price)] call life_fnc_numberText];
}
	else
{
	if(playerSide == west) then {
		if(_item in ownedWeapons) then {_price = 0} else {
			_price = _price * 0.85;
		};
		_ind = [_item,life_prestige_array] call fnc_index;
		if(_ind != -1 && !(call life_coplevel == 3 && _item in ["srifle_EBR_F","srifle_DMR_03_F"])) then {_prestigePrice = (life_prestige_array select _ind) select 1; _prestige = true; ctrlShow[1070,true]} else {ctrlShow[1070,false]};
		if(call life_coplevel == 3 && _item in ["srifle_EBR_F","srifle_DMR_03_F"]) then {_price = 25000};
		//if(_item in ["srifle_EBR_F","srifle_DMR_03_F"] && call style < 1 && !(_item in ownedWeapons)) then {ctrlShow[38405,false]; ctrlShow[38406,false]} else {ctrlShow[38405,true]; ctrlShow[38406,true]};
	};
	if(!(life_weaponShop in["gang","rebel"])) then {_price = _price * (1 + ((life_rules select 1) / 100))};
	_price = floor _price;
	if(_price > life_handpaper) then
	{
		_out = format["<t size='0.8'>Cost: <t color='#ff0000'>$%1",[(_price)] call life_fnc_numberText];
		if(playerSide == west && _prestige) then {_out = _out + format["<t color='#FFFFFF'>/%1PP",_prestigePrice]};
		_priceTag ctrlSetStructuredText parseText format [_out + "<br/>You lack: <t color='#8cff9b'>$%1</t></t>",[(_price - life_handpaper)] call life_fnc_numberText];
	}
		else
	{
		_out = "";
		if(_price == 0) then {_out = "<t size='0.8'>Free!"} else {
			_out = format["<t size='0.8'>Cost: <t color='#8cff9b'>$%1",[(_price)] call life_fnc_numberText];
			if(playerSide == west && _prestige) then {_out = _out + format["<t color='#FFFFFF'>/%1PP",_prestigePrice]};
		};
		_priceTag ctrlSetStructuredText parseText _out;
	};
};
_control lbSetValue[_index,_price];
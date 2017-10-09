#include <macro.h>
/*
	File: fn_buyClothes.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Buys the current set of clothes and closes out of the shop interface.
*/
private["_price"];
if((lbCurSel 3101) == -1) exitWith {titleText[localize "STR_Shop_NoClothes","PLAIN"];};

_price = 0;
{
	if(_x != -1) then
	{
		_price = _price + _x;
	};
} foreach life_clothing_purchase;

_price = (_price * __GETC__(life_vip_discount));

if(_price > life_handpaper) exitWith {titleText[localize "STR_Shop_NotEnoughClothes","PLAIN"];};
["cash","take",_price] call life_fnc_handlePaper;

life_clothesPurchased = true;
closeDialog 0;
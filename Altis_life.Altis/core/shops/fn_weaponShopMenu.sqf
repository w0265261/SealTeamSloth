#include <macro.h>
/*
	File: fn_weaponShopMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Something
*/
private["_config","_itemInfo","_itemList"];
uiNamespace setVariable ["Weapon_Shop",_this select 3];
life_weaponShop = _this select 3;
disableSerialization;
if(!(createDialog "STS_life_weapon_shop")) exitwith {};

_config = [_this select 3] call life_fnc_weaponShopCfg;
if(typeName _config == "STRING") exitWith {hint _config; closeDialog 0;};
_out = _config select 0;
if(playerSide == west) then {_out = _out + format["; Prestige: %1",life_prestige]
} else {
	if(playerSide == civilian && !(life_weaponShop in["gang","rebel"])) then {
		_out = _out + format["; Tax: %1%2",life_rules select 1,"%"];
	};
};
ctrlSetText[38401,_out];
ctrlShow[1070,false];
_filters = ((findDisplay 38400) displayCtrl 38402);
lbClear _filters;

_filters lbAdd localize "STR_Shop_Weapon_ShopInv";
_filters lbAdd localize "STR_Shop_Weapon_YourInv";

_filters lbSetCurSel 0;
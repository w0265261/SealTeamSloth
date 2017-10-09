#include <macro.h>
/*
	File: fn_prestigeBuy.sqf
	Author: Kevin Webb
	
	Description:
	Permanently purchases the chosen weapon for police with prestige points
*/
disableSerialization;
if((lbCurSel 38403) == -1) exitWith {hint localize "STR_Shop_Weapon_NoSelect"};
_item = lbData[38403,(lbCurSel 38403)];
if(_item in ownedWeapons) exitWith {hint "You already own this weapon."};
_index = [_item,life_prestige_array] call fnc_index;
_price = (life_prestige_array select _index) select 1;
if(life_prestige < _price) exitWith {hint format["You're lacking %1 prestige points for this purchase. Go make more proper arrests!",_price - life_prestige]};
life_prestige = life_prestige - _price;
[getPlayerUID player,playerSide,life_prestige,7,_item] remoteExec ["DB_fnc_updatePartial",2];
ownedWeapons pushBack _item;
[_item,true,false,false,false,false,false,true] spawn life_fnc_handleItem;
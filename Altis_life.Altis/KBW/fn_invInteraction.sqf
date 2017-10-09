#include <macro.h>
/*
	fn_invInteraction.sqf
	Kevin Webb
	Handles interacting with home inventory
*/
disableSerialization;
private["_price","_item","_itemInfo","_bad"];
if((lbCurSel 38403) == -1) exitWith {hint "No selection"};
_item = lbData[38403,(lbCurSel 38403)];
_itemInfo = [_item] call life_fnc_fetchCfgDetails;

_bad = "";

if((_itemInfo select 6) != "CfgVehicles") then
{
	if((_itemInfo select 4) in [4096,131072]) then
	{
		if(uniform player != "" && _itemInfo select 5 == 801 && (uiNameSpace getVariable["Weapon_Shop_Filter",0]) != 1) exitWith {_bad = (localize "STR_NOTF_NoRoom")};
		if(!(player canAdd _item) && (uiNameSpace getVariable["Weapon_Shop_Filter",0]) != 1) exitWith {
			if(vest player == "" && _itemInfo select 5 == 701) exitWith {};
			if(uniform player == "" && _itemInfo select 5 == 801) exitWith {};
			if(headGear player == "" && _itemInfo select 5 == 605) exitWith {};
			_bad = (localize "STR_NOTF_NoRoom");
		};
	};
};
if(_itemInfo select 6 == "CfgWeapons" && {(_itemInfo select 4) in [1,2]}) then
{
	if(((primaryWeapon player != "" && _itemInfo select 4 == 1) || (handgunWeapon player != "" && _itemInfo select 4 == 2)) && uiNameSpace getVariable["Weapon_Shop_Filter",0] != 1) exitWith {_bad = (localize "STR_NOTF_NoRoom")};
};
if(_bad != "") exitWith {hint _bad};
_house = (nearestBuilding (position player));
if(_house getVariable["invUsers",""] != getPlayerUID player) exitWith
{
    hint "Someone else is currently using the house inventory";
	closeDialog 0;
};
_inv = _house getVariable["containers",[]];
if((uiNameSpace getVariable["Weapon_Shop_Filter",0]) == 1) then
{
	switch(true) do {
		case(_item == primaryWeapon player): {
			{
				if(_x != "") then {
					_index = [_x,_inv] call fnc_index;
					if(_index == -1) then {
						_inv pushBack [_x,1];
					} else {
						_inv set [_index,[_x,((_inv select _index) select 1)+1]];
					};
				}
			} forEach primaryWeaponItems player;
		};
		case(_item == handgunWeapon player): {
			{
				if(_x != "") then {
					_index = [_x,_inv] call fnc_index;
					if(_index == -1) then {
						_inv pushBack [_x,1];
					} else {
						_inv set [_index,[_x,((_inv select _index) select 1)+1]];
					};
				}
			} forEach handgunItems player;
		};
		case(_item == backPack player): {
			{
				_index = [_x,_inv] call fnc_index;
				if(_index == -1) then {
					_inv pushBack [_x,1];
				} else {
					_inv set [_index,[_x,((_inv select _index) select 1)+1]];
				};
			} forEach backPackItems player;
		};
		case(_item == vest player && !(_item in (backpackItems player))): {
			{
				_index = [_x,_inv] call fnc_index;
				if(_index == -1) then {
					_inv pushBack [_x,1];
				} else {
					_inv set [_index,[_x,((_inv select _index) select 1)+1]];
				};
			} forEach vestItems player;
		};
		case(_item == uniform player && !(_item in (backpackItems player))): {
			{
				_index = [_x,_inv] call fnc_index;
				if(_index == -1) then {
					_inv pushBack [_x,1];
				} else {
					_inv set [_index,[_x,((_inv select _index) select 1)+1]];
				};
			} forEach uniformItems player;
		};
	};
	//Fix for a stupid BIS issue below, removeItem only has local effects????? WHY
	_myItems = [];
	_testBool = true;
	switch(true) do {
		case (_item in vestItems player): {_myItems = vestitems player; clearItemCargoGlobal vestContainer player; clearWeaponCargoGlobal vestContainer player; clearMagazineCargoGlobal vestContainer player; {if(_x == _item && _testBool) then {_testBool = false} else {vestContainer player addItemCargoGlobal [_x,1]}} forEach _myItems};
		case (_item in backpackItems player): {_myItems = backpackItems player; clearItemCargoGlobal backpackContainer player; clearWeaponCargoGlobal backpackContainer player; clearMagazineCargoGlobal backpackContainer player; {if(_x == _item && _testBool) then {_testBool = false} else {backpackContainer player addItemCargoGlobal [_x,1]}} forEach _myItems};
		case (_item in uniformItems player): {_myItems = uniformitems player; clearItemCargoGlobal uniformContainer player; clearWeaponCargoGlobal uniformContainer player; clearMagazineCargoGlobal uniformContainer player; {if(_x == _item && _testBool) then {_testBool = false} else {uniformContainer player addItemCargoGlobal [_x,1]}} forEach _myItems};
		default {[_item] call life_fnc_handleItem};
	};
	_index = [_item,_inv] call fnc_index;
	if(_index == -1) then {
		_inv pushBack [_item,1];
	} else {
		_inv set [_index,[_item,((_inv select _index) select 1)+1]];
	};
	_house setVariable["containers",_inv,true];
	[nil,1] call KBW_fnc_houseInvFilter; /*Update the menu.*/
}
	else
{
	_index = [_item,_inv] call fnc_index;
	if(((_inv select _index) select 1) == 1) then {
		_inv = _inv - [[_item,1]];
	} else {
		_inv set [_index,[_item,((_inv select _index) select 1)-1]];
	};
	[_item,true,false,false,false,false,false,true] call life_fnc_handleItem;
	_house setVariable["containers",_inv,true];
	[nil,0] call KBW_fnc_houseInvFilter; /*Update the menu.*/
};
if(!life_diagWaiting) then {
	life_diagWaiting = true;
	_house spawn {
		waitUntil {!dialog};
		[_this,false,_this getVariable "containers"] remoteExecCall ["TON_fnc_updateHouseContainers",2];
		[] call life_fnc_saveThat;
		life_diagWaiting = false;
	};
};
/*
    File: fn_civLoadGear.sqf
    Author: Bryan "Tonic" Boardwine
   
    Description:
    Loads saved civilian gear.
*/
private["_itemArray","_uniform","_vest","_backpack","_goggles","_headgear","_items","_prim","_seco","_uItems","_bItems","_vItems","_pItems","_hItems","_yItems","_uMags","_bMags","_vMags","_handle"];
_itemArray = life_gear;
_paint = param [0,false,[false]];
if(isNil "_itemArray" || count _itemArray == 0) exitWith {
switch(playerSide) do
{
	case civilian: {[] call life_fnc_civDefault;};
	case west: {[] call life_fnc_copDefault;};
};
};
/*Strip the unit down*/
RemoveAllWeapons player;
{player removeMagazine _x;} foreach (magazines player);
removeUniform player;
removeVest player;
removeBackpack player;
removeGoggles player;
removeHeadGear player;
{
    player unassignItem _x;
    player removeItem _x;
} foreach (assignedItems player);
 
_uniform = [_itemArray,0,"",[""]] call BIS_fnc_param;
_vest = [_itemArray,1,"",[""]] call BIS_fnc_param;
_backpack = [_itemArray,2,"",[""]] call BIS_fnc_param;
_goggles = [_itemArray,3,"",[""]] call BIS_fnc_param;
_headgear = [_itemArray,4,"",[""]] call BIS_fnc_param;
_items = [_itemArray,5,[],[[]]] call BIS_fnc_param;
_prim = [_itemArray,6,"",[""]] call BIS_fnc_param;
_seco = [_itemArray,7,"",[""]] call BIS_fnc_param;
_uItems = [_itemArray,8,[],[[]]] call BIS_fnc_param;
_bItems = [_itemArray,9,[],[[]]] call BIS_fnc_param;
_vItems = [_itemArray,10,[],[[]]] call BIS_fnc_param;
_pItems = [_itemArray,11,[],[[]]] call BIS_fnc_param;
_hItems = [_itemArray,12,[],[[]]] call BIS_fnc_param;
_yItems = [_itemArray,13,[],[[]]] call BIS_fnc_param;
 
if(_goggles != "") then {_handle = [_goggles,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_headgear != "") then {_handle = [_headgear,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_uniform != "") then {_handle = [_uniform,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_vest != "") then {_handle = [_vest,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_backpack != "") then {_handle = [_backpack,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};};
{(vestContainer player) addItemCargoGlobal [_x select 0,_x select 1];} foreach (_vItems);
{(backpackContainer player) addItemCargoGlobal [_x select 0, _x select 1];} foreach (_bItems);
if(_prim != "") then {_handle = [_prim,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};};
if(_seco != "") then {_handle = [_seco,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};};
{_handle = [_x,true,false,false,false] spawn life_fnc_handleItem; waitUntil {scriptDone _handle};} foreach _items;
{
    if (_x != "") then {
        player addPrimaryWeaponItem _x;
    };
} foreach (_pItems);
{
    if (_x != "") then {
        player addHandgunItem _x;
    };
} foreach (_hItems);
{(uniformContainer player) addItemCargoGlobal [_x select 0, _x select 1];} foreach (_uItems);
life_maxWeight = 100;
if(!_paint) then {
{
    _item = [_x select 0,1] call life_fnc_varHandle;
    [true,_item,_x select 1] call life_fnc_handleInv;
} foreach (_yItems);
};
_cfg = getNumber(configFile >> "CfgVehicles" >> (backpack player) >> "maximumload");
_load = round(_cfg / 8);
life_maxWeight = 24 + _load;
if(!("ItemRadio" in assignedItems player) && !("ItemRadio" in items player)) then {
player addItem "ItemRadio";
player assignItem "ItemRadio";
};
if(!("ItemMap" in assignedItems player) && !("ItemMap" in items player)) then {
player addItem "ItemMap";
player assignItem "ItemMap";
};
if(!("ItemCompass" in assignedItems player) && !("ItemCompass" in items player)) then {
player addItem "ItemCompass";
player assignItem "ItemCompass";
};
if(!("ItemWatch" in assignedItems player) && !("ItemWatch" in items player)) then {
player addItem "ItemWatch";
player assignItem "ItemWatch";
};
[] call life_fnc_equipGear;
if(backPack player == "B_Kitbag_sgg") then {unitBackpack player setObjectTextureGlobal [0,""]};
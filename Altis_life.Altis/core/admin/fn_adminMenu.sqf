#include <macro.h>
/*
	File: fn_adminMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Opens the admin menu, sorry nothing special in here. Take a look for yourself.
*/
if(__GETC__(style) < 1) exitWith {closeDialog 0;};
private["_display","_list","_side"];
disableSerialization;
waitUntil {!isNull (findDisplay 2900)};
_display = findDisplay 2900;
_list = _display displayCtrl 2902;
_out = format["Players Online: %1",count playableUnits];
ctrlSetText[2901,_out];
if(__GETC__(style) < 1) exitWith {closeDialog 0;};
/*Purge List*/
lbClear _list;

{
	//_side = switch(side _x) do {case west: {"Cop"}; case civilian : {"Civ"}; case independent : {"Medic"}; default {"Unknown"};};
	_list lbAdd format["%1 - %2", name _x,_x];
	_list lbSetdata [(lbSize _list)-1,str(_x)];
} foreach playableUnits;
if(__GETC__(style) < 1) exitWith {closeDialog 0;};
if(count playableUnits > 5) then { ctrlShow [1337,false]; };
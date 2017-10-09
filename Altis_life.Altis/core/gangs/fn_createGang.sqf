#include <macro.h>
/*
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pulls up the menu and creates the gang?
*/
private["_gangName","_length","_badChar","_chrByte","_allowed"];
disableSerialization;
_exit = false;
{if(player in (units(_x select 1))) exitWith {_exit = true};} forEach life_gang_list;
if(_exit) exitWith {hint "You seem to be in a temp group at the moment, leave it first!"};
_gangName = ctrlText (getControl(2520,2522));
_length = count (toArray(_gangName));
_chrByte = toArray (_gangName);
_allowed = toArray("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ ");
if(_length > 32) exitWith {hint localize "STR_GNOTF_Over32"};
_badChar = false;
{if(!(_x in _allowed)) exitWith {_badChar = true;};} foreach _chrByte;
if(_badChar) exitWith {hint localize "STR_GNOTF_IncorrectChar";};
if(life_myfunds < (__GETC__(life_gangPrice))) exitWith {hint format[localize "STR_GNOTF_NotEnoughMoney",[((__GETC__(life_gangPrice))-life_myfunds)] call life_fnc_numberText];};

[player,getPlayerUID player,_gangName] remoteExec ["TON_fnc_insertGang",2];
hint localize "STR_NOTF_SendingData";
closeDialog 0;
life_action_gangInUse = true;
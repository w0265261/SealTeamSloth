#include <macro.h>
/*
Author: Kevin Webb
Calls an airdrop
*/
if(__GETC__(style) < 2) exitWith {closeDialog 0; hint "This isn't for you to use";};
closeDialog 0;
[] spawn {
	_action = [
		"Are you sure you wish to initiate an airdrop mission? It will be called on the point where you are standing!",
		"Airdrop Mission",
		localize "STR_Global_Yes",
		localize "STR_Global_No"
	] call BIS_fnc_guiMessage;
	if(!_action) exitWith {};
	[position player] remoteExec ["TON_fnc_generateAirdrop",2];
};
	
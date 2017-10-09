#include <macro.h>
/*
fn_hideMe.sqf
Author: Kevin Webb
Description: For dat undercover work!
*/
if(__GETC__(style) < 1) exitWith {hint "Insufficient permissions"; closeDialog 0; };
if(player getVariable["invis",false]) then {
	[player] remoteExec ["life_fnc_hiderFunction",2];
	player setVariable["invis",false,true];
	player allowDamage true;
	//hint "Invisibility deactivated!";
} else {
	[player,true] remoteExec ["life_fnc_hiderFunction",2];
	player setVariable["invis",true,true];
	player allowDamage false;
	//hint "Invisibility activated!";
	//[3,format["%1 has donned his cloak of invisibility",profileName]] remoteExec ["life_fnc_broadcast",0];
};
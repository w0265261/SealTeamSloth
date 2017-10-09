#include <macro.h>
/*
File: adminDebugCon.sqf
Author: Kevin Webb
Description: opens the debug console, mainly used on my testing server. Button is commented out in the live build.
*/
if(__GETC__(style) < 3) exitWith {};
life_charged = false;
[] spawn {
	disableSerialization;
	createDialog "STS_KBW_price_diag";
	waitUntil{!isNull (findDisplay 13371)};
	ctrlSetText[2651,"Admin Debug Console"];
	_button = findDisplay 13371 displayCtrl 2650;
	_button ctrlSetText "Execute";
	while{!isNull (findDisplay 13371)} do {
		waitUntil{isNull (findDisplay 13371) || life_charged};
		if(!(life_charged)) exitWith {};
		_code = compile (ctrlText 7331);
		call _code;
		life_charged = false;
	};
};
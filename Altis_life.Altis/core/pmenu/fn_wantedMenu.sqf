#include <macro.h>
/*
	File: fn_wantedMenu.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Opens the Wanted menu and connects to the APD.
*/
private["_display","_list","_name","_crimes","_bounty","_units"];
disableSerialization;

createDialog "STS_life_wanted_menu";

_display = findDisplay 2400;
_list = _display displayCtrl 2401;
lbClear _list;
_units = [];

/*ctrlSetText[2404,"Establishing connection..."];*/
((findDisplay 2400) displayCtrl 2404) ctrlSetStructuredText parseText "Establishing connection...";

if(playerSide == west) then {
	((findDisplay 2400) displayCtrl 2406) ctrlSetStructuredText parseText format ["Welcome Back Officer %1", name player];
} else {
	((findDisplay 2400) displayCtrl 2406) ctrlSetStructuredText parseText format ["Welcome Back %1", name player];
};

if(__GETC__(life_coplevel) < 3 && __GETC__(style) == 0 && !life_governor) then
{
	ctrlShow[2405,false];
};

call life_fnc_wantedList;
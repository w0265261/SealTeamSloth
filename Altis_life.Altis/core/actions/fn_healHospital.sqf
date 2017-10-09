/*
	File: fn_healHospital.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Doesn't matter, will be revised later.
*/
_multiplier = switch(life_rules select 2) do {
	case 0: {1};
	case 1: {0.5};
	case 2: {0};
};
if(life_myFunds < (10 * _multiplier) && !(_this select 3)) exitWith {hint format[localize "STR_NOTF_HS_NoCash",10 * _multiplier];};
titleText[localize "STR_NOTF_HS_Healing","PLAIN"];
sleep 8;
if(player distance (_this select 0) > 5) exitWith {titleText[localize "STR_NOTF_HS_ToFar","PLAIN"]};
titleText[localize "STR_NOTF_HS_Healed","PLAIN"];
player setdamage 0;
if(!(_this select 3)) then {
	["atm","take",10 * _multiplier] call life_fnc_handlePaper;
};
if(life_rules select 2 > 0) then {systemChat format["Healthcare expenses have been reduced thanks to President %1!",life_rules select 5]};
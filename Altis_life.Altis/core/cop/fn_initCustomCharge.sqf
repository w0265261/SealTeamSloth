#include <macro.h>
/*
fn_initCustomCharge.sqf
Kevin Webb
Let the insanity of custom bounty strings and values ensue!
*/
private["_reason","_amount","_unit"];
if(__GETC__(life_coplevel) < 4 && __GETC__(style) < 1) exitWith { hint "Not yet, grasshopper!"; };
_unit = lbData[1338,lbCurSel (1338)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
if(_unit == player) exitWith { hint "You may not charge yourself"; };
if(side _unit != civilian) exitWith {hint "You may not charge non-civilians"; };
createDialog "STS_customCharge_ui";
waitUntil{!isNull (findDisplay 13371)};
waitUntil{isNull (findDisplay 13371) || life_charged};
if(!(life_charged)) exitWith {};
life_charged = false;
_amount = ctrlText 7331;
_reason = ctrlText 7332;
if(!([_amount] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0;};
if(parseNumber(_amount) <= 0) exitWith { hint "Invalid number"; closeDialog 0; };
_max = 0;
if(__GETC__(style) > 0) then { _max = 10000; } else { _max = 2000; };
if(parseNumber(_amount) > _max) exitWith { hint "You may not have a bounty higher than $2000 in your custom charge."; closeDialog 0; };
if(count _reason > 25) exitWith {hint "Your custom charge is too long, please shorten it before filing."; closeDialog 0;};
[getPlayerUID _unit,name _unit,[_reason,parseNumber(_amount)],_unit,[name player]] remoteExec ["life_fnc_customWantedAdd",2];
closeDialog 0;
[0,format["%1 was charged with %3 by %2",_unit getVariable["realname",name _unit],profileName,_reason]] remoteExec ["life_fnc_broadcast",west];
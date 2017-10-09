#include <macro.h>
/*
File: fn_compRequest.sqf
Author: Kevin Webb
Description: Sorts out what needs to be done to a player's cash, then adjusts it.
*/
if(__GETC__(style) < 2) exitWith {hint "This is only for moderators and higher"; };
private["_amount","_type"];
_type = param [0,0,[0]];
_amount = ctrlText 7331;
_uid = ctrlText 7332;
_reason = ctrlText 7333;
_msg = "";
if(_type == 0) then {
	_msg = format["The admin %1 has given $%2 to UID %3 for reason %4",profileName,_amount,_uid,_reason];
} else {
	_msg = format["The admin %1 has taken $%2 from the bank of UID %3 for reason %4",profileName,_amount,_uid,_reason];
};
if(!([_amount] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number.";};
if(parseNumber(_amount) <= 0) exitWith { hint "Invalid number"; };

[_type,parseNumber(_amount),_uid] remoteExec ["TON_fnc_compUID",2];
closeDialog 0;
[3,-1,_msg] call life_fnc_newMsg;
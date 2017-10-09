/*
	File: fn_phoneCall.sqf
	Author: John "Paratus" VanderZwet
	Modified by Kevin for optimization and compatibility
	Description:
	Initiate or receive a phone call.
*/

private ["_init","_unit","_callStart"];
_init = param [0,true,[true]];
_unit = param [1];
_exit = false;
if(_init && {typeName _unit == "STRING"} && {isNull (missionNameSpace getVariable[_unit,ObjNull])}) exitWith {hint "The dispatcher is not currently online.";};
if(typeName _unit == "STRING") then {_unit = cop_16};
if(lbCurSel 88881 == -1 && isNull _unit) exitWith {hint localize "STR_Global_NoSelection"};
if(isNull _unit) then {_unit = life_smartPhoneTarget};
if (life_phone_status != 0 || life_phone_channel > -1) exitWith {
	if(_init) then {hint "You must first hang up on your original phone call to start a new one"};
};

_callStart = time;

if (_init) then
{
	if (life_phone_channel > -1) exitWith {};
	life_phone_status = 2;
	[[0,2], format["Calling %1...", name _unit]] call life_fnc_broadcast;
	[false,player] remoteExec ["life_fnc_phoneCall",_unit];
	while {life_phone_status == 2} do
	{
		if (life_phone_channel > -1) exitWith { life_phone_status = 3 };
		if (time - _callStart > 60) exitWith { life_phone_status = 0 };
		playSound "PhoneDial";
		sleep 4;
	};
	if (life_phone_status == 0) then { [[0,2], format["%1 did not answer their phone.", name _unit]] call life_fnc_broadcast; };
	if (life_phone_status == 3 || life_phone_channel > -1) then { [[0,2], format["%1 added to phone session.", name _unit]] call life_fnc_broadcast; };
}
else
{
	life_phone_status = 1;
	[[0,2], format["Incoming call from %1. Press 9 to answer or 8 to ignore.", name _unit]] call life_fnc_broadcast;
	while {life_phone_status == 1} do
	{
		if (time - _callStart > 55) exitWith { life_phone_status = 0 };
		playSound "PhoneRing";
		sleep 3;
	};
	if (life_phone_status == 3) then
	{
		if(player == missionNameSpace getVariable["cop_16",objNull]) then {[_unit, 2, false] spawn life_fnc_breakInMarker};
		[_unit,player,false] remoteExecCall ["KBW_fnc_managePhone",2];
	};
};
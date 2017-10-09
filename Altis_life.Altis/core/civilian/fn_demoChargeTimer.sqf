/*
	File: fn_demoChargeTimer.sqf
	Author: Tonic
	Description: Specifies the time for the federal reserve blasting charge.
*/
private["_uiDisp","_time","_timer","_case"];
_case = param [0,false,[false]];
disableSerialization;
6 cutRsc ["life_timer","PLAIN"];
_uiDisp = uiNamespace getVariable "life_timer";
_timer = _uiDisp displayCtrl 38301;
if(!(_case)) then {
_time = time + 300; } else {
_time = time + (9 * 60); };
while {true} do {
	if(isNull _uiDisp) then {
		6 cutRsc ["life_timer","PLAIN"];
		_uiDisp = uiNamespace getVariable "life_timer";
		_timer = _uiDisp displayCtrl 38301;
	};
	if(round(_time - time) < 1) exitWith {};
	if(!(fed_bank getVariable["chargeplaced",false]) && _case) exitWith {};
	if(!(Jail_Target getVariable["chargeplaced",false]) && !_case) exitWith {};
	_timer ctrlSetText format["%1",[(_time - time),"MM:SS.MS"] call BIS_fnc_secondsToString];
	sleep 0.08;
};
6 cutText["","PLAIN"];
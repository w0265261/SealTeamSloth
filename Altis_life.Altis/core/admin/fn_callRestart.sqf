#include <macro.h>
/*
fn_callRestart.sqf
Kevin Webb
Calls a restart for you
*/
private["_action","_amount","_msg"];
if(__GETC__(style) < 1) exitWith {};
closeDialog 0;
if(life_restart) exitWith {
_action = [
"Do you wish to cancel the restart?",
"Cancelling restart",
localize "STR_Global_Yes",
localize "STR_Global_No"
] call BIS_fnc_guiMessage;
if(_action) then {life_restart = false;};
};
_action = [
"This will call out a server restart, but you will still be responsible for restarting the server at the appointed time. Are you sure?",
"Call server restart",
localize "STR_Global_Yes",
localize "STR_Global_No"
] call BIS_fnc_guiMessage;
if(_action) then {
	createDialog "STS_KBW_price_diag";
	waitUntil{!isNull (findDisplay 13371)};
	_disp = findDisplay 13371;
	_disp displayCtrl 2651 ctrlSetText "Automated Server Restart Message";
	_disp displayCtrl 7331 ctrlSetText "Enter time in minutes";
	waitUntil{isNull (findDisplay 13371) || life_charged};
	if(!(life_charged)) exitWith {};
	life_charged = false;
	_amount = ctrlText 7331;
	closeDialog 0;
	if(!([_amount] call fnc_isnumber)) exitWith {hint "You didn't enter an actual number."; closeDialog 0;};
	_amount = parseNumber(_amount);
	if(_amount <= 10) exitWith { hint "You can not enter a time less than or equal to 10 minutes. If you still wish to restart the server in a shorter time, do it manually."; closeDialog 0; };
	if(_amount > 60) exitWith { hint "I'd prefer you enter a time less than or equal to 60 minutes."; closeDialog 0; };
	life_restart = true;
	_msg = format["An admin has announced a server restart. The server will be restarted in %1 minutes.",_amount];
	[_msg] call fnc_cell_adminmsgall;
	_amount = _amount * 60;
	while{life_restart && _amount > 600} do
	{
		uiSleep 1; 
		_amount = _amount - 1;
	};
	if(!life_restart) exitWith {
	_msg = "The server restart has been cancelled";
	[_msg] call fnc_cell_adminmsgall;};
	_msg = "The server restart will occur in 10 minutes";
	[_msg] call fnc_cell_adminmsgall;
	while{life_restart && _amount > 120} do
	{
		uiSleep 1; 
		_amount = _amount - 1; 
	};
	if(!life_restart) exitWith {
	_msg = "The server restart has been cancelled";
	[_msg] call fnc_cell_adminmsgall;};
	_msg = "The server restart will occur in 2 minutes!";
	[_msg] call fnc_cell_adminmsgall;
	while{life_restart && _amount > 60} do
	{
		uiSleep 1; 
		_amount = _amount - 1; 
	};
	if(!life_restart) exitWith {
	_msg = "The server restart has been cancelled";
	[_msg] call fnc_cell_adminmsgall;};
	[] remoteExec ["SOCK_fnc_syncData",civilian];
	[] remoteExec ["TON_fnc_saveVehicles",2];
	uiSleep 30;
	_msg = "Message to admins: It is now 30 seconds until the appointed time of the restart. Be sure that it is restarted on time!";
	[_msg] call fnc_cell_textadmin;
};
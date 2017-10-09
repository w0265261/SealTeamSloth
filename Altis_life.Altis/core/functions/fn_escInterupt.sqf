/*
	File: fn_escInterupt.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Monitors when the ESC menu is pulled up and blocks off
	certain controls when conditions meet.
*/

private["_abortButton","_respawnButton","_fieldManual","_escSync","_canUseControls"];
disableSerialization;

_escSync = {
	private["_abortButton","_thread","_syncManager"];
	disableSerialization;
	
	_syncManager = {
		disableSerialization;
		private["_abortButton","_timeStamp"];
		_abortButton = (findDisplay 49) displayCtrl 104;
		_timeStamp = time + 5;
		
		waitUntil {
			_abortButton ctrlSetText format[localize "STR_NOTF_AbortESC",[(_timeStamp - time),"SS.MS"] call BIS_fnc_secondsToString];
			_abortButton ctrlCommit 0;
			round(_timeStamp - time) <= 0 || isNull (findDisplay 49)
		};
		
		_abortButton ctrlSetText "Quit STS Life";
		_abortButton ctrlCommit 0;
		_abortButton buttonSetAction "[] call SOCK_fnc_updateRequest";
	};
	
	_abortButton = (findDisplay 49) displayCtrl 104;
	_respawnButton = (findDisplay 49) displayCtrl 1010;
	/*if(!(life_respawning)) then {
		[] call SOCK_fnc_updateRequest;
	};*/
	if(_this) then {
		_thread = [] spawn _syncManager;
		waitUntil{scriptDone _thread OR isNull (findDisplay 49)};
		_abortButton ctrlEnable true;
		_respawnButton ctrlEnable true;
	};
};

_canUseControls = {
	if((player getVariable["restrained",FALSE]) OR (player getVariable["Escorting",FALSE])  OR (life_istazed) OR (life_abort_enabled) OR (player getVariable["zipTie",FALSE]) OR life_paintBalling) then {false} else {true};
};
	
while {true} do
{
	waitUntil{!isNull (findDisplay 49)};
	escMenuOpen = true;
	_abortButton = (findDisplay 49) displayCtrl 104;
	_respawnButton = (findDisplay 49) displayCtrl 1010;
	_fieldManual = (findDisplay 49) displayCtrl 122;
	_respawnButton ctrlSetText "Suicide";
	/*Block off our buttons first.*/
	_abortButton ctrlEnable false;
	_respawnButton ctrlEnable false;
	if(player getVariable["unconscious",false]) then {_respawnButton ctrlEnable true} else {_respawnButton ctrlEnable false;};
	if(player getVariable["restrained",false] || life_paintBalling || player getVariable["zipTie",false]) then {_respawnButton ctrlEnable false};
	_fieldManual ctrlShow false;
	
	_usebleCtrl = call _canUseControls;
	_usebleCtrl spawn _escSync;
	waitUntil{isNull (findDisplay 49)};
	escMenuOpen = nil;
};

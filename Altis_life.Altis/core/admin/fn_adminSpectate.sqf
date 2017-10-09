#include <macro.h>
/*
	File: fn_adminSpectate.sqf
	Author: ColinM9991
	Edited and Modified by CDawg for STS
	Description:
	Spectate the chosen player.
*/
if(__GETC__(style) == 0) exitWith {closeDialog 0;};
if(!isNull objectParent player) exitWith {hint "You should be on foot in order to spectate"};
private["_unit","_scrubMarker"];
_unit = lbData[2902,lbCurSel (2902)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
_test = player getVariable["invis",false];
if(!_test) then {[] call life_fnc_hideMe};
[] spawn {
  while {dialog} do {
   closeDialog 0;
   sleep 0.05;
  };
};
_scrubMarker = createMarkerLocal[format["%1",name _unit],position _unit];
_scrubMarker setMarkerTypeLocal "hd_warning";
_scrubMarker setMarkerTextLocal format["%1",name _unit];
_scrubMarker setMarkerColorLocal "ColorWhite";
life_originalPosition = getPosATL player;
player switchCamera "EXTERNAL";
life_voyeur = true; /*Cause you're weird like that*/
_unit spawn {
	_unit = _this;
	sleep 0.5;
	player attachTo[vehicle _unit,[0,-2,0]];
	while{life_voyeur} do {
		_state = vehicle _unit;
		waitUntil{uiSleep 0.5; (vehicle _unit != _state || !life_voyeur)};
		if(!life_voyeur) exitWith {};
		player attachTo[vehicle _unit,[0,-2,0]];
	};
};
hint format["You are now spectating %1 \n\n Press F10 to stop Spectating.",_unit getVariable["realname",name _unit]];
//[3,format["%2 is now spectating %1!",_unit getVariable["realname",name _unit],profileName]] remoteExec ["life_fnc_broadcast",0];
Fire_Handle = (player addEventHandler["Fired",{deleteVehicle (_this select 6); titletext["You can't fire while spectating","PLAIN"]}]);
AM_Exit = (findDisplay 46) displayAddEventHandler ["KeyDown","if((_this select 1) == 68) then {life_voyeur = false; (findDisplay 46) displayRemoveEventHandler ['KeyDown',AM_Exit];};false"];
[_scrubMarker,_unit,_test] spawn {
	waitUntil{sleep 0.5; (_this select 0) setMarkerPosLocal getPos (_this select 1); !life_voyeur};
	deleteMarker (_this select 0);
	detach player;
	player setVelocity [0,0,0];
	player setPosATL life_originalPosition;
	if(!(_this select 2)) then {[] call life_fnc_hideMe};
	player removeEventHandler ["Fired",Fire_Handle];
	//[3,format["%1 has stopped spectating!",profileName]] remoteExec ["life_fnc_broadcast",0];
};
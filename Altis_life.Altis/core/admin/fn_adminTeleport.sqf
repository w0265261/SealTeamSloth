#include <macro.h>
/*
	File: fn_adminTeleport.sqf
	Author: ColinM9991
	Credits: To original script author(s) & Ciaran from AL Forums
	Edited and Modified by CDawg for STS
	Description:
	Teleport to chosen position.
*/
if(__GETC__(style) < 4) exitWith {hint "This is for seniors and up to use";};

[] spawn {
  while {dialog} do {
   closeDialog 0;
   sleep 0.05;
  };
};

abcd={
	(vehicle player) setpos _this;
	onMapSingleClick "";
	openMap [false, false];
	hint "You have teleported to your selected position";
	if(!(player getVariable["invis",false])) then {
	[3,format["The admin %1 has teleported!",profileName]] remoteExec ["life_fnc_broadcast",0]; };
};
openMap [true, false];
onMapSingleClick "_pos call abcd; true";
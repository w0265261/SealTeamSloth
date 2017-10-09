/*
	File: fn_shankAction.sqf
	Author: Pennyworth
	
	Description:
	Shanks the target.
*/
private["_unit"];

_unit = cursorTarget;
if(time - life_previous_shank < 60) exitWith { titleText["You may only shank someone once per minute.","PLAIN"]; };
totaltime = totaltime + 60;
life_previous_shank = time;
[player,"AwopPercMstpSgthWrflDnon_End2"] remoteExec ["life_fnc_animSync",0];
[_unit, "shank",10] remoteExec ["life_fnc_playSound",0];
[player, true] remoteExec ["life_fnc_handleDowned",_unit];
[false,"shank",1] call life_fnc_handleInv;	
titleText[format["You shanked %1!",name _unit],"PLAIN"]; 
deleteVehicle life_placing;
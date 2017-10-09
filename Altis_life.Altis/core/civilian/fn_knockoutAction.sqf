/*
	File: fn_knockoutAction.sqf
	Author: Bryan "Tonic" Boardwine

*/
private["_target"];
_target = param [0,ObjNull,[ObjNull]];

/*Error checks*/
if(isNull _target) exitWith {};
if(!isPlayer _target) exitWith {};
if(player distance _target > 4 || missionNameSpace getVariable["life_jury_active",false]) exitWith {};
life_knockout = true;
[_target, "knockout",30] remoteExec ["life_fnc_playSound",0];
[player,"AwopPercMstpSgthWrflDnon_End2"] remoteExec ["life_fnc_animSync",0];
sleep 0.08;
[_target,player] remoteExec ["life_fnc_knockedOut",_target,false];
sleep 15;
life_knockout = false;
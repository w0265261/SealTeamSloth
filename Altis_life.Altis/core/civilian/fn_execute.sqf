/*
	File: fn_execute
	
	Author: Bobbus
	
	Description: is used to execute players
*/
private["_unit"];
_unit = param [0,ObjNull,[ObjNull]];
if(isNull _unit) exitWith {};
if(!isPlayer _unit) exitWith {};
if(!(_unit isKindOf "Man")) exitWith {};
if(_unit == player) exitWith {};
if(player distance _unit > 4) exitWith {};
if(_unit getVariable ["executed",false]) exitWith {};
life_exec = true;
player playMove "AinvPknlMstpSnonWnonDnon_medic1"; /*idk what animation to really do...*/
[player] remoteExec ["life_fnc_executeAction",_unit];
[false,"lethali",1] call life_fnc_handleInv;
sleep 3;
if(side _unit != west) then {
	[getPlayerUID player,profileName,"187",[_unit getVariable["realname",name _unit],getPos player,"Injection"]] remoteExec ["life_fnc_wantedAdd",2]; 
} else {
	[getPlayerUID player,profileName,"187A",[_unit getVariable["realname",name _unit],getPos player,"Injection"]] remoteExec ["life_fnc_wantedAdd",2]; 
};
titleText ["You are a murderer.","PLAIN"];